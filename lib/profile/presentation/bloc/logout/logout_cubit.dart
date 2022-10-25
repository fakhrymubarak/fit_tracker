import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fit_tracker/profile/domain/usecases/logout_usecase.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase useCase;

  LogoutCubit(this.useCase) : super(LogoutInitial());

  FutureOr<void> logoutUser() async {
    await useCase.execute();
    emit(LogoutSuccess());
  }
}
