import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustommTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? prefixIcon;
  String? suffixIcon;
   CustommTextField({Key? key,this.controller,this.suffixIcon,this.hintText,this.prefixIcon});

  @override
  State<CustommTextField> createState() => _CustommTextFieldState();
}

class _CustommTextFieldState extends State<CustommTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17)
      ),
      child: TextField(
        style: TextStyle(fontSize: 12.sp),
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
          hintText: widget.hintText,
          labelStyle: TextStyle(fontSize: 10.sp,color: Colors.grey),
          hintStyle: TextStyle(fontSize: 9.sp,color: Color(0xff181F30)),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: widget.suffixIcon!=null ? Padding(
            padding:  EdgeInsets.only(top: 2.8.h,bottom: 2.5.h,right: 3.w),
            child: SvgPicture.asset(widget.suffixIcon!,height: 2.h,),
          ) : SizedBox(),
          //suffixIconColor: appColor,
          //iconColor: appColor,
          prefixIcon:  Padding(
            padding:  EdgeInsets.only(left: 3.w,top: 2.8.h,bottom: 2.5.h,right: 2.w),
            child: SvgPicture.asset(widget.prefixIcon!,height: 2.h,),
          ),
          contentPadding: EdgeInsets.only(left: 2.w,right: 2.w,bottom: 1.5.h),
          disabledBorder: InputBorder.none,
          //focusedBorder: InputBorder.none,
          //enabledBorder: InputBorder.none
        ),
      ),
    );
  }
}
