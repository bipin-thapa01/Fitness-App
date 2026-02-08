import 'package:fitness/Screens/ForgotPasswordPage/forgot_password.dart';
import 'package:fitness/Screens/HomePage/home_page.dart';
import 'package:fitness/Screens/SignupPage/signup_page.dart';
import 'package:fitness/standardData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Map<String, String> requiredField = {
  'Email Address': 'Text',
  'Password': 'Password',
};

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _login();
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

  //to fetch email if an old user
  Future<void> _login() async {
    String? email = await storage.read(key: 'email');
    if (email != null) {
      setState(() {
        _controllers['Email Address']!.text = email;
      });
    }
  }

  //to authenticate user
  Future<void> _authenticate() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    final email = _controllers['Email Address']!.text;
    final password = _controllers['Password']!.text;
    final url = Uri.parse('http://192.168.1.64:8080/api/signin');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'email': email,
        'password': password,
      },
    );

    if (!mounted) return;
    Navigator.pop(context);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("Invalid Credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 30,
          children: [
            ...requiredField.entries.map((item) {
              bool isPassword = item.value == 'Password';
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _controllers[item.key],
                  obscureText: isPassword ? _isObscured : false,
                  decoration: InputDecoration(
                    prefixIcon: isPassword
                        ? Icon(Icons.lock)
                        : Icon(Icons.email),
                    suffixIcon: isPassword
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )
                        : null,
                    hint: Text(item.key),
                    filled: true,
                    fillColor: StandardData.backgroundColor1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 1,
                        color: StandardData.primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
            Column(
              spacing: 20,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text("Forgot Password?"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _authenticate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: StandardData.primaryColor,
                    ),
                    child: Text("Log in"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: StandardData.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
