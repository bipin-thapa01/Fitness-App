import 'dart:convert';

import 'package:fitness/Screens/HomePage/home_page_appbar.dart';
import 'package:fitness/Screens/HomePage/home_page_calorie.dart';
import 'package:fitness/Screens/LoginPage/login_page.dart';
import 'package:fitness/standardData.dart';
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
      floatingActionButton: IconButton(
        iconSize: 30,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 0.5,
                expand: false,
                builder: (context, scrollController) {
                  return Container(child: CustomScrollView(slivers: []));
                },
              );
            },
          );
        },
        icon: Icon(Icons.qr_code_scanner),
        style: IconButton.styleFrom(backgroundColor: StandardData.primaryColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(Icons.dashboard),
                Text("Dashboard", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.fitness_center),
                Text("Workout", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.calendar_month),
                Text("Progress", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.settings),
                Text("Settings", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
