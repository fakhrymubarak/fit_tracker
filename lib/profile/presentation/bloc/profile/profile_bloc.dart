import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/profile/domain/entities/user_profile.dart';
import 'package:fit_tracker/profile/domain/usecases/update_profile_usecase.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc(this.getProfileUseCase, this.updateProfileUseCase)
      : super(ProfileInitial()) {
    on<ProfileFetchEvent>(
      _fetchProfile,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  FutureOr<void> _fetchProfile(
    ProfileFetchEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await getProfileUseCase.execute();

    result.fold(
      (failure) => emit(ProfileErrorState(failure.message)),
      (data) => emit(ProfileHasDataState(data)),
    );
  }
}
