import 'package:flutter/material.dart';

class FoodData extends StatefulWidget {
  final Map<String, dynamic> product;
  const FoodData({super.key, required this.product});

  @override
  State<FoodData> createState() => _FoodDataState();
}

class _FoodDataState extends State<FoodData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.product['name']));
  }
}
