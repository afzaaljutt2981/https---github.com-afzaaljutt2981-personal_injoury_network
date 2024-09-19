import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
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
      ) 
          ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
