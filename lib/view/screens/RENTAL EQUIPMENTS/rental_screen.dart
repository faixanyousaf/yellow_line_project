import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RentalEquipments extends StatefulWidget {
  const RentalEquipments({Key? key}) : super(key: key);

  @override
  State<RentalEquipments> createState() => _RentalEquipmentsState();
}

class _RentalEquipmentsState extends State<RentalEquipments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyRequestMainScreen(),));
      //   },
      // ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (
                    context, index) => Column(
                  children: [
                    ExpansionTile(
                      title: Text("Backhoe"),
                      leading: Container(
                        height: 6.h,
                        width: 14.w,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Divider(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
