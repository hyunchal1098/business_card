import 'package:business_card/screen/main_screen.dart';
import 'package:business_card/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF151026);

    return MaterialApp(
      title: 'Business Card',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/main": (context) => MainScreen(),
      },
    );
  }
}
