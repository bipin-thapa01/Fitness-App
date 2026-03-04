import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';

class HomePageSkill extends StatefulWidget {
  final List<dynamic> data;
  const HomePageSkill({super.key, required this.data});

  @override
  State<HomePageSkill> createState() => _HomePageSkillState();
}

class _HomePageSkillState extends State<HomePageSkill> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    List<Map<String, dynamic>> habits = List<Map<String, dynamic>>.from(
      widget.data,
    );
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
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddNewHabit();
                },
              );
            },
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
            spacing: 10,
            children: [
              Text(
                "Your current habits",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              habits.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(top: 5),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: habits.length > 5 ? 5 : habits.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "${index + 1}. ${habits[index]['habit']}",
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: StandardData.primaryColor
                                .withOpacity(0.5),
                          ),
                          child: Text("View all"),
                        ),
                      ],
                    )
                  : Text(
                      "Empty Habits List!",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddNewHabit extends StatefulWidget {
  const AddNewHabit({super.key});

  @override
  State<AddNewHabit> createState() => _AddNewHabitState();
}

class _AddNewHabitState extends State<AddNewHabit> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: StandardData.primaryColor,
              ),
            ),
            Text(
              "Add New Habit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).primaryColor,
                      hint: Text("New Habit"),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      spacing: 20,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: StandardData.primaryColor
                                .withAlpha(90),
                          ),
                          child: Text("Save"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.2),
                          ),
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
