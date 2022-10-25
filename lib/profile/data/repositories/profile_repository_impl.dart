import 'package:dartz/dartz.dart';
import 'package:fit_tracker/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../domain/entities/user_profile.dart';
import '../data_sources/profile_remote_data_sources.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final Preferences preference;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.preference,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);
        debugPrint('profile repo uid -> $uid');

        if (uid == null) {
          logoutUser();
          return const Left(AuthFailure(
              'Your session has been expired, please login again.'));
        }

        final result = await remoteDataSource.getUserProfile(uid);
        preference.setBool(
            PrefKey.isProfileCompleted, result.isProfileComplete);
        return Right(result);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(
    String name,
    Gender gender,
    String birthDate,
    int height,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await preference.getString(PrefKey.userUid);
        final email = await preference.getString(PrefKey.email);

        if (uid == null && email == null) {
          logoutUser();
          return const Left(AuthFailure(
              'Your session has been expired, please login again.'));
        }

        final profile = UserProfile(
          uid: uid!,
          email: email!,
          name: name,
          gender: gender,
          birthDate: birthDate,
          height: height,
          profileUrl: '',
          isProfileComplete: true,
        );

        final result = await remoteDataSource.updateUserProfile(profile);
        preference.setBool(PrefKey.isProfileCompleted, profile.isProfileComplete);
        return Right(result);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(ConnectionFailure.networkFailure);
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      preference.removeKey([
        PrefKey.userUid,
        PrefKey.isProfileCompleted,
      ]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
