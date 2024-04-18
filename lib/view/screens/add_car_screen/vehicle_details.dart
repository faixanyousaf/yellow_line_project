import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../global_widgets/image_finder.dart';
import '../../../global_widgets/data_loading.dart';
import '../../../global_widgets/image_view_screen.dart';
import 'Models/view_list_vehicle_model.dart';

class VehicleDetails extends StatefulWidget {
  final ViewAllVehicle? vehicle;
  const VehicleDetails({super.key, this.vehicle});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        //toolbarHeight: 9.h,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 5.w,
            )),
        title: Text(
          'Vehicles Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          Image(image: AssetImage('assets/bells.png')),
          SizedBox(
            width: 3.w,
          ),
          Padding(
            padding: EdgeInsets.only(right: 6.w),
            child: Container(
              height: 7.h,
              width: 5.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(width: 0.6, color: Colors.white)),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 3.w,
                ),
              ),
            ),
          )
        ],
      ),
      body: DataLoading(
        isLoading: load,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 9.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.vehicle!.code}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff181F30), fontSize: 16.sp),
                            ),
                          ),
                          Container(
                            width: 0.3.w,
                            color: Color(0xffADADAD),
                          ),
                          Expanded(
                            child: Image.network('${widget.vehicle!.cityLogo}'),
                          ),
                          Container(
                            width: 0.3.w,
                            color: Color(0xffADADAD),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              '${widget.vehicle!.plateNumber}',
                              style: TextStyle(
                                  color: Color(0xff181F30), fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Code:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.code}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Plate Number:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.plateNumber}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Type:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.make}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Make:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.make}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Model:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.model}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Year:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      '${widget.vehicle!.year}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Registration card',
                  style: TextStyle(
                      color:  Colors.white,
                      fontSize: 10.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: InkWell(
                    onTap: () async{
                      if (getType_of_url(
                          '${widget.vehicle!.registrationCard}')) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ImageView(
                              imageV: [
                                '${widget.vehicle!.registrationCard}'
                              ],
                              slectedIndex: 0,
                            )));
                      } else {
                        load = true;
                        setState(() {});
                        await launch_doc_URL(
                        url: '${widget.vehicle!.registrationCard}');
                        load = false;
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 12.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Image.network(
                          '${widget.vehicle!.registrationCard}',
                          errorBuilder: (a, b, c) {
                            return Icon(
                              Icons.file_copy,
                              color: Color(0xffFFD542),
                              size: 50,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
