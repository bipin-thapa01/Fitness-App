import 'package:fitness/Screens/NewUserLanding/new_user_landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: NewUserLandingPage(),
    );
  }
}
