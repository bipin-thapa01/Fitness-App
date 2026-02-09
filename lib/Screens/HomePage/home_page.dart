import 'dart:convert';

import 'package:fitness/Screens/HomePage/home_page_appbar.dart';
import 'package:fitness/Screens/HomePage/home_page_calorie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final encData = await storage.read(key: "user");
    setState(() {
      data = jsonDecode(encData!);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomePageAppbar(data: data),
          SliverToBoxAdapter(child: HomePageCalorie()),
        ],
      ),
    );
  }
}
