import 'dart:convert';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:fitness/Screens/HomePage/home_page.dart';
import 'package:fitness/Screens/NewUserLanding/new_user_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void initOpenFoodFacts() {
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'fitness_app',
    version: '1.0',
  );
  OpenFoodAPIConfiguration.globalLanguages = [OpenFoodFactsLanguage.ENGLISH];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.NEPAL;
}

void main() {
  initOpenFoodFacts();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFetching = true;
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final encData = await storage.read(key: "user");
    if (encData == null) {
      setState(() {
        isFetching = false;
        data = null;
      });
    } else {
      setState(() {
        isFetching = false;
        data = jsonDecode(encData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: isFetching
          ? Loading()
          : data != null
          ? HomePage()
          : NewUserLandingPage(),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
