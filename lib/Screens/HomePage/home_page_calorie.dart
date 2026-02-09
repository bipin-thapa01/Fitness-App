import 'package:fitness/standardData.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePageCalorie extends StatefulWidget {
  const HomePageCalorie({super.key});

  @override
  State<HomePageCalorie> createState() => _HomePageCalorieState();
}

class _HomePageCalorieState extends State<HomePageCalorie> {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  List<List<dynamic>> details = [
    [
      Icon(Icons.restaurant_menu, color: StandardData.iconColor1),
      "Consumed",
      "2000",
    ],
    [
      Icon(Icons.local_fire_department, color: StandardData.iconColor2),
      "Burned",
      "1000",
    ],
  ];
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${months[now.month - 1]} ${now.day}, ${now.year}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: StandardData.backgroundColor1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(
                          "Net Calories",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 55,
                          lineWidth: 8,
                          percent: 0.8,
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: StandardData.mainColor,
                          progressColor: StandardData.primaryColor,
                          animation: true,
                          animationDuration: 1200,
                          center: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "80%\n",
                              children: [
                                TextSpan(
                                  text: "done",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        spacing: 10,
                        children: [
                          ...details.map((item) {
                            return Row(
                              spacing: 5,
                              children: [
                                item[0],
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item[1],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      item[2],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
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
