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
          hintStyle: TextStyle(fontSize: 10.sp,color: Color(0xff181F30)),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: widget.suffixIcon!=null ? Padding(
            padding:  EdgeInsets.only(top: 2.h,bottom: 1.5.h,right: 3.w),
            child: SvgPicture.asset(widget.suffixIcon!,height: 2.h,),
          ) : null,
          //suffixIconColor: appColor,
          //iconColor: appColor,
          prefixIcon: widget.prefixIcon!=null ? Container(
            height: 0.5.h,
              width: 0.5.w,
              child: Padding(
                padding:  EdgeInsets.all(15.0),
                child: SvgPicture.asset(widget.prefixIcon!,),
              )) : null,
          contentPadding: EdgeInsets.only(left: 3.w,right: 2.w,bottom: 1.5.h),
          disabledBorder: InputBorder.none,
          //focusedBorder: InputBorder.none,
          //enabledBorder: InputBorder.none
        ),
      ),
    );
  }
}


