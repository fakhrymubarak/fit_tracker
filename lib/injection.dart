import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'profile/profile.dart';
import 'register/register.dart';

final injector = GetIt.instance;

void init() {
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  injector.registerLazySingleton<Preferences>(() => PreferencesImpl());

  _loginInjector();
  _registerInjector();
  _profileInjector();
  _userWeightInjector();
}

void _userWeightInjector() {
  injector.registerFactory(() => ListWeightCubit(injector()));
  injector.registerFactory(() => WeightBloc(injector(), injector()));

  injector.registerLazySingleton(
      () => GetUserWeightsUseCase(repository: injector()));
  injector
      .registerLazySingleton(() => InsertWeightUseCase(repository: injector()));
  injector
      .registerLazySingleton(() => UpdateWeightUseCase(repository: injector()));

  injector.registerLazySingleton<WeightRepository>(() => WeightRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
      preference: injector()));

  injector.registerLazySingleton<WeightRemoteDataSource>(
      () => WeightRemoteDataSourceImpl());
}

void _loginInjector() {
  injector.registerFactory(() => LoginBloc(injector(), injector()));

  injector
      .registerLazySingleton(() => LoginUserUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => CheckHasLoginUseCase(repository: injector()));

  injector.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
      preference: injector()));

  injector.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
}

void _registerInjector() {
  injector.registerFactory(() => RegisterBloc(injector()));

  injector
      .registerLazySingleton(() => RegisterUserUseCase(repository: injector()));

  injector.registerLazySingleton<RegisterRepository>(() =>
      RegisterRepositoryImpl(
          remoteDataSource: injector(), networkInfo: injector()));

  injector.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl());
}

void _profileInjector() {
  injector.registerFactory(() => ProfileBloc(injector(), injector()));
  injector.registerFactory(() => EditProfileBloc(injector()));
  injector.registerFactory(() => LogoutCubit(injector()));

  injector
      .registerLazySingleton(() => GetProfileUseCase(repository: injector()));
  injector.registerLazySingleton(
      () => UpdateProfileUseCase(repository: injector()));
  injector.registerLazySingleton(() => LogoutUseCase(repository: injector()));

  injector.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      remoteDataSource: injector(),
      preference: injector(),
      networkInfo: injector()));

  injector.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
}
