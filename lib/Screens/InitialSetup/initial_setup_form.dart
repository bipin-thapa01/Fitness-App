import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> requiredFields = [
  {'name': 'Age', 'type': 'Input', 'unit': 'years'},
  {
    'name': 'Gender',
    'type': 'Option',
    'options': ['Male', 'Female'],
  },
  {'name': 'Height', 'type': 'Input', 'unit': 'cm'},
  {'name': 'Weight', 'type': 'Input', 'unit': 'kg'},
  {'name': 'Target Weight', 'type': 'Input', 'unit': 'kg'},
  {
    'name': 'Target Body Type',
    'type': 'Option',
    'options': ['Slim', 'Normal', 'Athletic', 'Bulky'],
  },
];

class InitialSetupForm extends StatefulWidget {
  const InitialSetupForm({super.key});

  @override
  State<InitialSetupForm> createState() => _InitialSetupFormState();
}

class _InitialSetupFormState extends State<InitialSetupForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Form(
        child: Column(
          spacing: 30,
          children: [
            ...requiredFields.map((item) {
              if (item['type'] == 'Input') {
                return TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: StandardData.backgroundColor1,
                    hintText: item['name'],
                    suffixText: item['unit'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: StandardData.primaryColor),
                    ),
                  ),
                );
              } else {
                return DropdownMenu(dropdownMenuEntries: item['options']);
              }
            }),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: StandardData.primaryColor,
                ),
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
