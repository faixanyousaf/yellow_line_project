import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  String? text;
  Color? buttonColor;
  Color? borderColor;
  Color? textColor;
   CustomButton({Key? key,this.text,this.borderColor,this.buttonColor,this.textColor,}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        height: 6.5.h,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          //Color(0xffFFD542),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 0.8,color: widget.borderColor!)
        ),
        child: Center(
          child: Text(
            widget.text!,
            style: TextStyle(
                color: widget.textColor,
                //Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
