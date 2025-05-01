import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class Page_2 extends StatelessWidget {
  final List<Map<String, dynamic>> drivers = [
    {
      'name': 'Themba',
      'car': 'Volkswagen Polo',
      'rating': 5.0,
      'reviews': 895,
      'price': 'AED 50',
      'time': '3 min',
      'distance': '300 m',
      'image': 'assets/manbg.png',
    },
    {
      'name': 'James',
      'car': 'Hyundai Accent',
      'rating': 4.9,
      'reviews': 654,
      'price': 'AED 40',
      'time': '3 min',
      'distance': '500 m',
      'image': 'assets/manbg.png',
    },
    {
      'name': 'Thabang',
      'car': 'BMW 3 Series',
      'rating': 5.0,
      'reviews': 584,
      'price': 'AED 65',
      'time': '5 min',
      'distance': '1 km',
      'image': 'assets/manbg.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        title: const Text(
          'All Drivers',
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle cancel action
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'You can accept or decline offers',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 50), // Placeholder for spacing
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  final driver = drivers[index];
                  return Card(
                    color: Colors.black.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Profile Image
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage(driver['image']),
                              ),
                              SizedBox(width: 12.0),

                              // Driver Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driver['car'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      driver['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 16.0),
                                        Text(
                                          '${driver['rating']} (${driver['reviews']})',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Price and ETA
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    driver['price'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFFD542),
                                    ),
                                  ),
                                  Text(
                                    '${driver['time']}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                  Text(
                                    '${driver['distance']}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 5.h,
                                  child: Center(
                                    child: Text(
                                      'Decline',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: Colors.red)),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                child: Container(
                                  height: 5.h,
                                  child: Center(
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xffFFD542)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: LinearPercentIndicator(
                                  width: 85.w,
                                  animation: true,
                                  lineHeight: 1.5.h,
                                  animationDuration: 5000,
                                  percent: 0.7,
                                  barRadius: Radius.circular(30),
                                  progressColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
