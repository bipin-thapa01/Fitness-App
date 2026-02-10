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
  final _key = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    for (var item in requiredFields) {
      final String name = item["name"] as String;
      if (item['type'] == 'Input') {
        _controllers[name] = TextEditingController();
      } else {
        _selectedOptions[name] = null;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> submitData() async {
    if (_key.currentState!.validate()) {
      String age = _controllers['Age']!.text;
      String? gender = _selectedOptions['Gender'];
      String height = _controllers['Height']!.text;
      String weight = _controllers['Weight']!.text;
      String targetWeight = _controllers['Target Weight']!.text;
      String? targetBodyType = _selectedOptions['Target Body Type'];
    } else {
      showDialog(
        context: context,
        builder: (context) {
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
                      Expanded(
                        child: Text("Please fill all the required fields!"),
                      ),
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
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Form(
        key: _key,
        child: Column(
          spacing: 30,
          children: [
            ...requiredFields.map((item) {
              if (item['type'] == 'Input') {
                return TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your ${item['name']}";
                    }
                    return null;
                  },
                  controller: _controllers[item['name']],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: StandardData.backgroundColor1,
                    labelText: item['name'],
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
                final List<String> options = (item['options'] as List)
                    .cast<String>();
                return DropdownMenu(
                  onSelected: (value) {
                    setState(() {
                      _selectedOptions[item['name']] = value;
                    });
                  },
                  label: Text(item['name']),
                  width: MediaQuery.of(context).size.width * 0.9,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: StandardData.backgroundColor1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: StandardData.primaryColor),
                    ),
                  ),
                  dropdownMenuEntries: options.map((option) {
                    return DropdownMenuEntry(value: option, label: option);
                  }).toList(),
                );
              }
            }),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  submitData();
                },
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
