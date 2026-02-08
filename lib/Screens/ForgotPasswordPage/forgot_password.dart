import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Column(
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  Text("Enter your email to reset your password"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Form(
                child: Column(
                  spacing: 30,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hint: Text("Email Address"),
                          filled: true,
                          fillColor: StandardData.backgroundColor1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: StandardData.primaryColor,
                        ),
                        child: Text("Continue"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
