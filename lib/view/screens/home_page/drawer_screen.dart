import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../helper/navigation/navigation_object.dart';
import '../../../helper/navigation/router_path.dart';
import '../../../helper/shared_prefs.dart';
import '../../Authentication Models/login/models/login_Responce_model.dart';
import '../authentication/login_screen/login_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    get_user_data();
    super.initState();
  }

  LoginResponceModel? loginResponceModel;
  get_user_data() async {
    SharedPrefs sf = SharedPrefs();
    var user = await sf.getUser();
    loginResponceModel = LoginResponceModel.fromJson(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 6.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 4.w,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                navigationService
                    .navigateTo(RouterPath.UpdateUserProfileScreen);
              },
              child: Container(
                height: 11.h,
                width: 22.w,
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.8, color: Colors.white)),
                child: loginResponceModel!.user!.profilePicture != null &&
                        loginResponceModel!.user!.profilePicture
                            .toString()
                            .isNotEmpty
                    ? CircleAvatar(
                        //radius: 30.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            '${loginResponceModel!.user!.profilePicture}'),
                      )
                    : Center(
                        child: Icon(
                          Icons.person,
                          size: 9.h,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            if (loginResponceModel != null)
              Text(
                '${loginResponceModel!.user!.firstName} ${loginResponceModel!.user!.lastName}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
            //SizedBox(height: 1.h,),
            if (loginResponceModel != null)
              Text(
                '${loginResponceModel!.user!.email}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp,
                ),
              ),
            SizedBox(
              height: 4.h,
            ),
            InkWell(
                onTap: () {
                  navigationService.navigateTo(RouterPath.Vehicle_List_Screen);
                },
                child: customListTile(
                    text: 'My Vehicle'.tr, image: 'assets/vehicle.png')),
            InkWell(
              onTap: () {
                navigationService.navigateTo(RouterPath.request_view_screen);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 3.8.h,
                          width: 7.4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color(0xffFFCC1B)),
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/request.png'),
                              height: 2.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'My Request'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 4.w,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              onTap: () {
                showMaterialModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  context: context,
                  backgroundColor: Color(0xffFFCC1B).withOpacity(0.1),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          color: Color(0xffFFCC1B).withOpacity(0.5),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 31.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xffD1E3F4),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            topLeft: Radius.circular(40)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Delete account?'.tr,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'Do you want to temporarily or permanently \ndelete your account?'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff261F21).withAlpha(150),
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context)
                                                    .pop('Temporarily');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 1.w),
                                                child: Container(
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffFFCC1B))),
                                                  child: Center(
                                                    child: Text(
                                                      'Temporarily'.tr,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFFCC1B),
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context)
                                                    .pop('Permanently');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 1.w),
                                                child: Container(
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color(0xffFFCC1B)),
                                                  child: Center(
                                                    child: Text(
                                                      'Permanently'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    if (value == 'Permanently') {
                      showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        context: context,
                        backgroundColor: Color(0xffFFCC1B).withOpacity(0.1),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                color: Color(0xffFFCC1B).withOpacity(0.5),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            topLeft: Radius.circular(40)),
                                      ),
                                      child: Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40)),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w,
                                                      vertical: 3.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/svgs/undo.svg',
                                                          height: 3.2.h,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Permanently delete'.tr,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFFCC1B),
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    right: 4.w,
                                                  ),
                                                  child: Container(
                                                    height: 15.h,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      initialValue:
                                                          'If you permanently delete your account all your data will be deleted from our backend system and you will not be able to reactivate it again. You will need to register as a new user if you would like rejoin sarya app.However if other users have purchased any itineraries or lists designed by you it will still be available for the user to use.'.tr,
                                                      textAlign: TextAlign.left,
                                                      maxLines: null,
                                                      enabled: false,
                                                      expands: true,
                                                      textAlignVertical:
                                                          TextAlignVertical.top,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              Colors.black45),
                                                      decoration:
                                                          InputDecoration(
                                                        enabled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        //isDense: true,
                                                        hintText:
                                                            'Specify Reason'.tr,
                                                        //  labelText: 'Title',
                                                        labelStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.grey),
                                                        hintStyle: TextStyle(
                                                            fontSize: 10.sp),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 2.h,
                                                                bottom: 2,
                                                                left: 4.w,
                                                                right: 2.w),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // AuthRepository.instance
                                                    //     .delete_account(body: {
                                                    //   'reason': ''
                                                    // });
                                                    Navigator.of(context)
                                                        .pop('true');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Container(
                                                      height: 7.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Color(
                                                              0xffFFCC1B)),
                                                      child: Center(
                                                        child: Text(
                                                          'Delete'.tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          showMaterialModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40)),
                            ),
                            context: context,
                            enableDrag: false,
                            backgroundColor: Color(0xffFFCC1B).withOpacity(0.1),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Container(
                                  color: Color(0xffFFCC1B).withOpacity(0.5),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 32.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(40)),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xffD1E3F4),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40),
                                                    topLeft:
                                                        Radius.circular(40)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Account Deleted Successfully'.tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              'Your account has been \npermanently deleted from the platform.'.tr,
                                              style: TextStyle(
                                                color: Color(0xff261F21)
                                                    .withAlpha(150),
                                                fontSize: 11.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: InkWell(
                                                onTap: () {
                                                  SharedPrefs sf =
                                                      SharedPrefs();
                                                  sf.clearCache();
                                                  navigationService
                                                      .pushAndRemoveUntil(
                                                          LogInScreen());
                                                },
                                                child: Container(
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color(0xffFFCC1B)),
                                                  child: Center(
                                                    child: Text(
                                                      'Okay'.tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).then((value) {});
                        } else {}
                      });
                    } else {
                      showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        context: context,
                        backgroundColor: Color(0xffFFCC1B).withOpacity(0.1),
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                color: Color(0xffFFCC1B).withOpacity(0.5),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            topLeft: Radius.circular(40)),
                                      ),
                                      child: Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40)),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w,
                                                      vertical: 3.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: SvgPicture.asset(
                                                          'assets/svgs/undo.svg',
                                                          height: 3.2.h,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Temporary delete'.tr,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFFCC1B),
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    right: 4.w,
                                                  ),
                                                  child: Container(
                                                    height: 15.h,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      initialValue:
                                                          'If you temporary delete your account, your profile, itineraries,and lists will be hidden from others until you reactivate it again by logging back in. However if other users have purchased any itineraries or lists designed by you it will still be available for the user to use.'.tr,
                                                      textAlign: TextAlign.left,
                                                      maxLines: null,
                                                      enabled: false,
                                                      expands: true,
                                                      textAlignVertical:
                                                          TextAlignVertical.top,
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              Colors.black45),
                                                      decoration:
                                                          InputDecoration(
                                                        enabled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        disabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Color(
                                                                  0xffFFCC1B)),
                                                        ),
                                                        //isDense: true,
                                                        hintText:
                                                            'Specify Reason'.tr,
                                                        //  labelText: 'Title',
                                                        labelStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.grey),
                                                        hintStyle: TextStyle(
                                                            fontSize: 10.sp),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 2.h,
                                                                bottom: 2,
                                                                left: 4.w,
                                                                right: 2.w),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pop('true');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Container(
                                                      height: 7.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Color(
                                                              0xffFFCC1B)),
                                                      child: Center(
                                                        child: Text(
                                                          'Delete'.tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 14.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ).then((value) {
                        if (value != null) {
                          showMaterialModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40)),
                            ),
                            context: context,
                            enableDrag: false,
                            backgroundColor: Color(0xffFFCC1B).withOpacity(0.1),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Container(
                                  color: Color(0xffFFCC1B).withOpacity(0.5),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 32.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(40)),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xffD1E3F4),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(40),
                                                    topLeft:
                                                        Radius.circular(40)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Account Deleted Successfully'.tr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              'Your account has been\ntemporary deleted from the platform.'.tr,
                                              style: TextStyle(
                                                color: Color(0xff261F21)
                                                    .withAlpha(150),
                                                fontSize: 11.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: InkWell(
                                                onTap: () {
                                                  SharedPrefs sf =
                                                      SharedPrefs();
                                                  sf.clearCache();
                                                  navigationService
                                                      .pushAndRemoveUntil(
                                                          LogInScreen());
                                                },
                                                child: Container(
                                                  height: 7.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color(0xffFFCC1B)),
                                                  child: Center(
                                                    child: Text(
                                                      'Okay',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).then((value) {});
                        } else {}
                      });
                    }
                  } else {}
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 3.8.h,
                          width: 7.4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color(0xffFFCC1B)),
                          child: Center(
                            child: Icon(
                              Icons.login_outlined,
                              size: 5.w,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          'Delete Account'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.delete_sweep_outlined,
                      size: 4.w,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 3.8.h,
                        width: 7.4.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xffFFCC1B)),
                        child: Center(
                          child: Icon(
                            Icons.login_outlined,
                            size: 5.w,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'Language'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  ToggleSwitch(
                    minHeight: 3.h,
                    minWidth: 12.w,
                    initialLabelIndex: 0,
                    cornerRadius: 4,
                    totalSwitches: 2,
                    labels: [
                      'ENG',
                      'العربية',
                    ],
                    //activeBgColor: Colors.grey,
                    inactiveBgColor: Colors.grey.withOpacity(0.7),
                    customTextStyles: [
                      TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )
                    ],
                    onToggle: (index) async {
                      print('switched to: $index');
                      if (index == 0) {
                        // await context.setLocale(Locale('en', 'US'));
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);

                      } else {
                        // await context.setLocale(Locale('ar', 'IQ'));
                        var locale = Locale('ar', 'IQ');
                        Get.updateLocale(locale);
                      }
                    },

                  ),
                ],
              ),
            ),

          ],
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              SharedPrefs sf = SharedPrefs();
              sf.clearCache();
              navigationService.pushAndRemoveUntil(LogInScreen());
            },
            child: Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                Container(
                  height: 4.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                      color: Color(0xffFF3E3E),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/logout.png'),
                          color: Colors.white,
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Logout'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: 5.h,
        )
      ],
    );
  }

  Widget customListTile({String? image, String? text}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(image!),
                    height: 3.8.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 4.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}
