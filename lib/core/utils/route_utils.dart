import 'package:flutter/material.dart';

import '/home/home.dart';
import '/login/login.dart';
import '/profile/profile.dart';
import '/register/register.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginPageRoute:
      return _toPage(const LoginPage());
    case registerPageRoute:
      return _toPage(const RegisterPage());
    case homePageRoute:
      return _toPage(const HomePage());
    case profilePageRoute:
      return _toPage(const ProfilePage());
    case editProfilePageRoute:
      return _toPage(const ProfilePage());
    default:
      return null;
  }
}

Route<dynamic> _toPage(Widget view, [RouteSettings? settings]) {
  return MaterialPageRoute(builder: (_) => view, settings: settings);
}

const String loginPageRoute = '/login';
const String registerPageRoute = '/register';
const String homePageRoute = '/home';
const String profilePageRoute = '/profile';
const String editProfilePageRoute = '/edit-profile';
