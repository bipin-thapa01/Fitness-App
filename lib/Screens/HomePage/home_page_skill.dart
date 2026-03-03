import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

class HomePageSkill extends StatefulWidget {
  const HomePageSkill({super.key});

  @override
  State<HomePageSkill> createState() => _HomePageSkillState();
}

class _HomePageSkillState extends State<HomePageSkill> {
  final List<String> habits = ['Workout', 'Code', 'Eat Healthy'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: StandardData.backgroundColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Establish new habit",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "Add new habit to level up!",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: StandardData.primaryColor.withOpacity(0.5),
            ),
            child: Text(
              "Add Habit",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.grey[800], thickness: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your current habits",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: habits.length > 5 ? 5 : habits.length,
                itemBuilder: (context, index) {
                  return Text("${index + 1} ${habits[index]}");
                },
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: StandardData.primaryColor.withOpacity(0.5),
                ),
                child: Text("View all"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
