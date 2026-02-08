import 'package:fitness/Screens/LoginPage/login_page.dart';
import 'package:fitness/Screens/SignupPage/signup_page.dart';
import 'package:fitness/standardData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewUserLandingPage extends StatelessWidget {
  const NewUserLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/landing_page_logo.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 1)],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Center(
              child: Column(
                spacing: 5,
                children: [
                  Text(
                    StandardData.appName,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                  ),
                  Text("The best fitness app in the market!"),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StandardData.primaryColor,
                      ),
                      child: Text("Get Started"),
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
