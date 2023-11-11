import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:personal_injury_networking/ui/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => MyProfileController()),
    ChangeNotifierProvider(create: (_) => EventsController())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: const MaterialColor(
        0xFF212E73,
        <int, Color>{
          50: Color(0xFF212E73),
          100: Color(0xFF212E73),
          200: Color(0xFF212E73),
          300: Color(0xFF212E73),
          400: Color(0xFF212E73),
          500: Color(0xFF212E73),
          600: Color(0xFF212E73),
          700: Color(0xFF212E73),
          800: Color(0xFF212E73),
          900: Color(0xFF212E73),
        },
      )),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
