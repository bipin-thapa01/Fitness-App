import 'package:fitness/Screens/FoodBarcode/food_data.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodBarcode extends StatefulWidget {
  const FoodBarcode({super.key});

  @override
  State<FoodBarcode> createState() => _FoodBarcodeState();
}

class _FoodBarcodeState extends State<FoodBarcode> {
  String? lastBarcode;
  Map<String, dynamic> productDetails = {};

  @override
  Widget build(BuildContext context) {
    Future<void> getProduct(String barcode) async {
      final ProductQueryConfiguration config = ProductQueryConfiguration(
        barcode,
        version: ProductQueryVersion.v3,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
      );

      final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(
        config,
      );

      if (result.status == ProductResultV3.statusFailure) {
        setState(() {
          productDetails['status'] = 'Product not found!';
        });
      } else {
        setState(() {
          productDetails['status'] = 'Product found!';
          productDetails['name'] = result.product?.productName ?? 'Unknown';
          productDetails['brand'] = result.product?.brands ?? 'Unknown';
          productDetails['category'] = result.product?.categories ?? 'Unknown';
          productDetails['image'] = result.product?.imageFrontUrl ?? 'Unknown';
          productDetails['serving_size'] =
              result.product?.servingSize ?? 'Unknown';
          productDetails['serving_quantity'] =
              result.product?.servingQuantity ?? 'Unknown';
          productDetails['protein'] =
              result.product?.nutriments?.getValue(
                Nutrient.proteins,
                PerSize.oneHundredGrams,
              ) ??
              'Unknown';
          productDetails['carbs'] =
              result.product?.nutriments?.getValue(
                Nutrient.carbohydrates,
                PerSize.oneHundredGrams,
              ) ??
              'Unknown';
          productDetails['fat'] =
              result.product?.nutriments?.getValue(
                Nutrient.fat,
                PerSize.oneHundredGrams,
              ) ??
              'Unknown';
          productDetails['sugar'] =
              result.product?.nutriments?.getValue(
                Nutrient.sugars,
                PerSize.oneHundredGrams,
              ) ??
              'Unknown';
        });
      }

      if (!mounted) return;

      print(productDetails);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodData(product: productDetails),
        ),
      ).then((_) {
        setState(() {
          lastBarcode = null;
        });
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                if (lastBarcode == barcodes.first.rawValue) {
                  return;
                }
                lastBarcode = barcodes.first.rawValue;
                getProduct(barcodes.first.rawValue!);
              }
            },
          ),
        ],
      ),
    );
  }
}
