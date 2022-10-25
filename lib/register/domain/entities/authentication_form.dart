import 'dart:core';

import 'package:equatable/equatable.dart';

class AuthenticationForm extends Equatable {
  final String email;
  final String password;

  const AuthenticationForm({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
