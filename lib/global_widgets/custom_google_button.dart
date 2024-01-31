import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomGoogleButton extends StatefulWidget {
  String? image;
  String? text;
   CustomGoogleButton({super.key,this.text,this.image});

  @override
  State<CustomGoogleButton> createState() => _CustomGoogleButtonState();
}

class _CustomGoogleButtonState extends State<CustomGoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        color: Color(0xffE8ECF4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Padding(
          padding:  EdgeInsets.only(left: 20.w),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(widget.image!),height: 3.h,),
              SizedBox(width: 6.w,),
              Text(
                widget.text!,
                style: TextStyle(
                    color: Color(0xff181F30),
                    fontSize: 12.sp
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
