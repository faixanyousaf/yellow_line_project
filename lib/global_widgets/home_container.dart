import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeContainer extends StatefulWidget {
  String? image;
  String? text;
   HomeContainer({Key? key,this.text,this.image}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19.h,
      width: 28.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            Container(
              height: 6.h,
              width: 12.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(image: AssetImage(widget.image!),),
              ),
            ),
            SizedBox(height: 3.h,),
            Text(
              widget.text!,
              style: TextStyle(color: Colors.white,fontSize: 11.sp,),
            ),
          ],
        ),
      ),
    );
  }
}
