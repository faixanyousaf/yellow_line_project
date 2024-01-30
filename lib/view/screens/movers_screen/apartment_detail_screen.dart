import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/movers_screen/mover_confirm_screen.dart';

class ApartmentDetailScreen extends StatefulWidget {
  const ApartmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<ApartmentDetailScreen> createState() => _ApartmentDetailScreenState();
}

class _ApartmentDetailScreenState extends State<ApartmentDetailScreen> {
  List<String>? list = [
    'Sofa',
    'Bed',
    'Dining Table',
    'Cupboards',
    'Refrigerator',
    'LED',
    'Air Conditioner',
    'Washing Machine'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 4.w,),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Color(0xff424755),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child: Column(
                    children: [
                      Container(
                        height: 4.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/ellipse.svg',height: 1.4.h,),
                                    SizedBox(width: 2.w,),
                                    Text(
                                      'Select Pickup Location',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.2.sp
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset('assets/remove.svg',height: 1.3.h,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 4.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/locate.svg',height: 1.5.h,),
                                    SizedBox(width: 2.w,),
                                    Text(
                                      'Select Drop-off Location',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.2.sp
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset('assets/remove.svg',height: 1.3.h,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.5.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: AssetImage('assets/google_map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.5.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w) ,
              child: Text(
                'Apartment Details:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 2.9.h,
              width: 100.w,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 5.w,),
                    Container(
                      height: 2.7.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        border: Border.all(width: 0.6,color: Colors.white)
                      ),
                      child: Center(
                        child: Text(
                          'Studio',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7.5.sp
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    Container(
                      height: 2.4.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                          border: Border.all(width: 0.6,color: Colors.white)
                      ),
                      child: Center(
                        child: Text(
                          '1 Bedroom',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7.5.sp
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    Container(
                      height: 2.4.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                          border: Border.all(width: 0.6,color: Colors.white)
                      ),
                      child: Center(
                        child: Text(
                          '2 Bedroom',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7.5.sp
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    Container(
                      height: 2.4.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                          border: Border.all(width: 0.6,color: Colors.white)
                      ),
                      child: Center(
                        child: Text(
                          '3 Bedroom',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7.5.sp
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'General items to be Moved:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp
                    ),
                  ),
                  SvgPicture.asset('assets/cam.svg',height: 1.9.h,),
                ],
              ),
            ),
            SizedBox(height: 1.h,),
           // Container(
           //   height: 40.h,
           //   child: ListView.builder(
           //     itemCount: list!.length,
           //     itemBuilder: (context, index) {
           //     return  itemContainer(item: list![index]);
           //   },),
           // ),
            itemContainer(item: 'Sofa'),
            itemContainer(item: 'Bed'),
            itemContainer(item: 'Dining Table'),
            itemContainer(item: 'Cupboards'),
            itemContainer(item: 'Refrigerator'),
            itemContainer(item: 'LED'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 3.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        border: Border.all(width: 0.7,color: Colors.white)
                    ),
                    child: Center(
                      child: Text(
                        'Air Conditioner',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/minus_icon.svg',height: 2.2.h,),
                      SizedBox(width: 2.w,),
                      Text(
                        '01',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      SvgPicture.asset('assets/plus_icon.svg',height: 2.h,),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 1.5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 3.h,
                    width: 27.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                        border: Border.all(width: 0.7,color: Colors.white)
                    ),
                    child: Center(
                      child: Text(
                        'Washing Machine',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/minus_icon.svg',height: 2.2.h,),
                      SizedBox(width: 2.w,),
                      Text(
                        '01',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      SvgPicture.asset('assets/plus_icon.svg',height: 2.h,),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Container(
              height: 9.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 5.w,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: AssetImage('assets/soofy.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: AssetImage('assets/washing.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: AssetImage('assets/soofy.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            CustomButton(
              buttonColor: Color(0xffFFD542),
              borderColor: Color(0xffFFD542),
              text: 'Confirm',
              textColor: Colors.black,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MoverConfirmScreen(),));
        },
      ),
    );
  }

  Widget itemContainer({String? item}){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 3.h,
                width: 20.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                    border: Border.all(width: 0.7,color: Colors.white)
                ),
                child: Center(
                  child: Text(
                    item!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/minus_icon.svg',height: 2.2.h,),
                  SizedBox(width: 2.w,),
                  Text(
                    '01',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  SvgPicture.asset('assets/plus_icon.svg',height: 2.h,),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 1.5.h,)
      ],
    );
  }

}
