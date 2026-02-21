import 'dart:convert';

import 'package:fitness/Screens/FoodBarcode/food_barcode.dart';
import 'package:fitness/Screens/HomePage/home_page_appbar.dart';
import 'package:fitness/Screens/HomePage/home_page_calorie.dart';
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
                initialChildSize: 0.35,
                expand: false,
                builder: (context, scrollController) {
                  return HomePageQRPopup();
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

class HomePageQRPopup extends StatefulWidget {
  const HomePageQRPopup({super.key});

  @override
  State<HomePageQRPopup> createState() => _HomePageQRPopupState();
}

class _HomePageQRPopupState extends State<HomePageQRPopup> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> popupButtons = [
      {
        'key1': 'Food Barcode',
        'value1': Icon(Icons.qr_code, color: StandardData.iconColor2),
        'key2': 'Search Food',
        'value2': Icon(Icons.search, color: StandardData.iconColor1),
        'onTap1': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodBarcode()),
          );
        },
        'onTap2': () {
          print("Search Food");
        },
      },
      {
        'key1': 'Scan Meal',
        'value1': Icon(Icons.camera_alt, color: StandardData.iconColor1),
        'key2': 'Add Meal',
        'value2': Icon(Icons.add, color: StandardData.iconColor2),
        'onTap1': () {
          print("Scan Meal");
        },
        'onTap2': () {
          print("Add Meal");
        },
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 35,
              height: 6,
              decoration: BoxDecoration(
                color: StandardData.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              spacing: 20,
              children: [
                ...popupButtons.map((item) {
                  return Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: item['onTap1'],
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: StandardData.backgroundColor1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [item['value1'], Text(item['key1'])],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: item['onTap2'],
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: StandardData.backgroundColor1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [item['value2'], Text(item['key2'])],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
