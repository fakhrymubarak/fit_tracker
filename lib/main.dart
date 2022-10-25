import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';
import 'injection.dart' as di;
import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      navigatorObservers: [routeObserver],
      theme: getAppTheme(context),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}
