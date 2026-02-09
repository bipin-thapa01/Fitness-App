import 'package:fitness/Screens/SignupPage/signup_page.dart';
import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final formKey;
  final Map<String, TextEditingController> controllers;
  const SignupForm({
    super.key,
    required this.formKey,
    required this.controllers,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Form(
        key: widget.formKey,
        child: Column(
          spacing: 25,
          children: [
            ...requiredField.entries.map((item) {
              bool isPassword = item.value == 'Password';
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: widget.controllers[item.key],
                  obscureText: isPassword ? _isObscured : false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: item.key == 'Name'
                        ? Icon(Icons.person)
                        : item.key == 'Email Address'
                        ? Icon(Icons.email)
                        : Icon(Icons.lock),
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
                    fillColor: StandardData.backgroundColor1,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: StandardData.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
