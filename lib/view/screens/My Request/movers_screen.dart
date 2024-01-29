import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MoversScreen extends StatefulWidget {
  const MoversScreen({Key? key}) : super(key: key);

  @override
  State<MoversScreen> createState() => _MoversScreenState();
}

class _MoversScreenState extends State<MoversScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100.h,
      width: 100.w,
      child: ListView.builder(itemCount: 4,itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          borderType: BorderType.Rect,
          //dashPattern: [6, 3, 2, 3],
          dashPattern: [10, 4],
          color: Color(0xffFFCC1B),
         // strokeCap: StrokeCap.butt,
          strokeWidth: 2,
          child: SizedBox(
            height: 16.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:2.h,),
                  const Text('19 Jan, 2024',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white)),
                  const Text('5 Quotations received',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff13F01C))),
                ],
              ),
            ),
          ),),
      ),),
    );
  }
}
