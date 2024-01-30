import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/movers_screen/apartment_detail_screen.dart';

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({Key? key}) : super(key: key);

  @override
  State<AddNewVehicleScreen> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,),
        title: Text(
          'Add New Vehicles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 5.w),
            child: Row(
              children: [
                Stack(
                  children: [
                    Image(image: AssetImage('assets/bells.png')),
                    Positioned(
                      top: 0,
                      left: 1.5.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 6.sp
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 3.w,),
                Container(
                  height: 4.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(width: 0.6,color: Colors.white)
                  ),
                  child: Center(
                    child: Icon(Icons.person,color: Colors.white,size: 3.w,),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 9.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            'Code',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp
                            ),
                          ),
                        ),
                        Container(
                          width: 0.3.w,
                          color: Color(0xffADADAD),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            'City',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp
                            ),
                          ),
                        ),
                        Container(
                          width: 0.3.w,
                          color: Color(0xffADADAD),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Number',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Select City',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 9.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.55.h,horizontal: 1.w),
                  child: Center(
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                        width: 25.w,
                        height: 9.h,
                        decoration: BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'أبو ظبي',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9.sp
                                ),
                              ),
                              SizedBox(height: 1.h,),
                              Text(
                                'Abu Dhabi',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9.sp
                                ),
                              )
                            ],
                          ),
                        ),
                    ),
                      ),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Code',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                hintText: 'Enter Code',
                controller: codeController,
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Plate Number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                hintText: 'Enter Plate Number',
                controller: numberController,
              ),
            ),
            SizedBox(height: 30.h,),
            CustomButton(
              textColor: Colors.black,
              text: 'Confirm',
              borderColor: Color(0xffFFCC1B),
              buttonColor: Color(0xffFFCC1B),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApartmentDetailScreen(),));
        },
      ),
    );
  }
}
