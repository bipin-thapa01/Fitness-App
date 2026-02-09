import 'dart:convert';
import 'package:fitness/Screens/LoginPage/login_page.dart';
import 'package:fitness/Screens/SignupPage/signup_form.dart';
import 'package:fitness/standardData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Map<String, String> requiredField = {
  'Name': 'Text',
  'Email Address': 'Text',
  'Password': 'Password',
};

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var key in requiredField.keys) {
      _controllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      final name = _controllers['Name']!.text;
      final email = _controllers['Email Address']!.text;
      final password = _controllers['Password']!.text;

      final url = Uri.parse('${StandardData.baseUrl}/api/signup');

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (res.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No previous page available")),
                  );
                }
              },
              icon: Icon(Icons.arrow_back_ios_new),
              style: IconButton.styleFrom(
                backgroundColor: StandardData.backgroundColor1,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Column(
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  Text(
                    "Create a new account to get started",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SignupForm(formKey: _formKey, controllers: _controllers),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                spacing: 20,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StandardData.primaryColor,
                      ),
                      onPressed: () {
                        _createAccount();
                      },
                      child: Text("Create Account"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a user? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: StandardData.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
