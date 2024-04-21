import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Tap to call',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  box(
                      name: 'Police',
                      number: '999',
                      onTap: () {
                        launchUrl(Uri.parse("tel://999"));
                      }),
                  SizedBox(
                    width: 3.w,
                  ),
                  box(
                      name: 'Ambulance',
                      number: '998',
                      onTap: () {
                        launchUrl(Uri.parse("tel://998"));
                      }),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  box(
                      name: 'Fire Department',
                      number: '997',
                      onTap: () {
                        launchUrl(Uri.parse("tel://997"));
                      }),
                  SizedBox(
                    width: 3.w,
                  ),
                  box(
                      name: 'Coastguard',
                      number: '996',
                      onTap: () {
                        launchUrl(Uri.parse("tel://996"));
                      }),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  box(
                      name: 'Find and Rescue',
                      number: '995',
                      onTap: () {
                        launchUrl(Uri.parse("tel://995"));
                      }),
                  SizedBox(
                    width: 3.w,
                  ),
                  box(
                      name: 'Electricity Failure',
                      number: '991',
                      onTap: () {
                        launchUrl(Uri.parse("tel://991"));
                      }),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  box(
                      name: 'Water Failure',
                      number: '995',
                      onTap: () {
                        launchUrl(Uri.parse("tel://995"));
                      }),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  box({required String name, required Function() onTap, String? number}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 14.h,
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xffFFCC1B))),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              '$name',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
