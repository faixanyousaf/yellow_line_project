import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff181F30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff181F30),
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white),
        title: const Text('Choose an equipment to Rent',style: TextStyle(fontSize: 14,
        color: Colors.white
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset('assets/svgs/search.svg',width: 6.w,height: 2.h),
          ),
        ],
      ),
    );
  }
}
