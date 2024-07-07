import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropContainer extends StatefulWidget {
  String? text;
  String? texxt;
  double? height;
  double? width;
  CustomDropContainer(
      {Key? key, this.text, this.height, this.width, this.texxt})
      : super(key: key);

  @override
  State<CustomDropContainer> createState() => _CustomDropContainerState();
}

class _CustomDropContainerState extends State<CustomDropContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Color(0xff424755),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text!,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
            Text(
              widget.texxt!,
              style: TextStyle(color: Color(0xffFFCC1B), fontSize: 10.sp),
            )
          ],
        ),
      ),
    );
  }
}
