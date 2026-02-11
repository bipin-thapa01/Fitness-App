import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

class Util {
  static AlertDialog showAlertBox(
    final BuildContext context,
    final String message,
  ) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 40, left: 10, right: 10),
      content: SizedBox(
        height: 100,
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: StandardData.primaryColor,
                ),
                Expanded(child: Text(message)),
              ],
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: StandardData.primaryColor,
                ),
                child: Text("Ok"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
