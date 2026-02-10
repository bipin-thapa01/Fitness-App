import 'package:fitness/Screens/InitialSetup/initial_setup_form.dart';
import 'package:flutter/material.dart';

class InitialSetup extends StatelessWidget {
  const InitialSetup({super.key});

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
              preferredSize: Size.fromHeight(80),
              child: Column(
                children: [
                  Text(
                    "Additional Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text("Enter additional information to proceed!"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: InitialSetupForm()),
        ],
      ),
    );
  }
}
