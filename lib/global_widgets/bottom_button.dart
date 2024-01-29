import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class CustomBottomButton extends StatefulWidget {
  String? text;
  Color? buttonColor;
  Color? borderColor;
  Color? textColor;
  CustomBottomButton({Key? key,this.text,this.borderColor,this.buttonColor,this.textColor,});

  @override
  State<CustomBottomButton> createState() => _CustomBottomButtonState();
}

class _CustomBottomButtonState extends State<CustomBottomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 43.w,
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
    );
  }
}
