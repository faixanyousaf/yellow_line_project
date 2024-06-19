import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../global_widgets/custom_button.dart';
import '../../../../../global_widgets/custom_textfield.dart';
import '../../../../global_widgets/data_loading.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../model/driver_profile_model.dart';
import '../view_model/update_user_profile_provider.dart';

class DriverProfileScreen extends StatefulWidget {
  final String? id;
  const DriverProfileScreen({Key? key, this.id}) : super(key: key);

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  dynamic formKey = GlobalKey<FormState>();

  @override
  void initState() {
    get_user_info();
    super.initState();
  }

  Driver_Profile_Model? loginResponceModel;
  get_user_info() async {
    final UpdateUserProfileProvider provider =
        Provider.of<UpdateUserProfileProvider>(context, listen: false);
    var profile_result =
        await UserRepository.instance.get_driver_profile(id: widget.id);
    loginResponceModel = Driver_Profile_Model.fromJson(profile_result);
    print('email.......${loginResponceModel?.email}');
    provider.emailController.text = loginResponceModel?.email ?? '';
    provider.first_name_Controller.text = loginResponceModel?.firstName ?? '';
    provider.last_name_Controller.text = loginResponceModel?.lastName ?? '';
    provider.phoneController.text = loginResponceModel?.phone ?? '';
    provider.loading = false;
    provider.liceince = null;
    provider.logo = null;
    provider.country_code = loginResponceModel?.dialCode ?? '+971';
    setState(() {});
  }

  @override
  void deactivate() {
    if (mounted) {
      final UpdateUserProfileProvider provider =
          Provider.of<UpdateUserProfileProvider>(context, listen: false);
      provider.emailController.text = '';
      provider.first_name_Controller.text = '';
      provider.last_name_Controller.text = '';
      provider.phoneController.text = '';
      provider.loading = false;
      provider.liceince = null;
      provider.logo = null;
      provider.country_code = '+971';
      provider.isVisible = false;
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final UpdateUserProfileProvider provider =
        Provider.of<UpdateUserProfileProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DataLoading(
        isLoading: provider.loading,
        child: Scaffold(
          backgroundColor: Color(0xff181F30),
          body: loginResponceModel == null
              ? DataLoading(
                  isLoading: true,
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                  ),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 4.5.w,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Profile'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    width: 30.w,
                                    child: Stack(
                                      children: [
                                        provider.logo == null
                                            ? Center(
                                                child: Container(
                                                  height: 11.h,
                                                  width: 25.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: loginResponceModel!
                                                                  .profilePhoto !=
                                                              null &&
                                                          loginResponceModel!
                                                              .profilePhoto
                                                              .toString()
                                                              .isNotEmpty
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  '${loginResponceModel!.profilePhoto}'),
                                                        )
                                                      : Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svgs/company_icon.svg',
                                                            height: 4.5.h,
                                                          ),
                                                        ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundImage:
                                                    FileImage(provider.logo!),
                                                radius: 6.h),
                                        Positioned(
                                          bottom: 2.w,
                                          right: 4.5.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFD542),
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.black,
                                                size: 1.7.h,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar(
                              initialRating: double.parse(
                                  '${loginResponceModel!.ratingAvg ?? 0}'),
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemSize: 5.w,
                              ratingWidget: RatingWidget(
                                full: SvgPicture.asset(
                                  'assets/svgs/rating_icon_fill.svg',
                                  color: Color(0xffFFCC1B),
                                ),
                                empty: SvgPicture.asset(
                                  'assets/svgs/rating_icon.svg',
                                  color: Color(0xffFFCC1B),
                                ),
                                half: SvgPicture.asset(
                                  'assets/svgs/rating_icon.svg',
                                  color: Color(0xffFFCC1B),
                                ),
                              ),
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              onRatingUpdate: (rnt) {},
                            ),
                            Text(
                              '(${loginResponceModel!.ratingAvg ?? 0}.0)',
                              style: TextStyle(color: Color(0xffFFCC1B)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: CustommTextField(
                            controller: provider.first_name_Controller,
                            prefixIcon: 'assets/svgs/company_icon.svg',
                            hintText: 'Company Name'.tr,
                            visible: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter company name'.tr;
                              } else {
                                return null;
                              }
                            },
                            //suffixIcon: 'assets/eyes.svg',
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: CustommTextField(
                            controller: provider.last_name_Controller,
                            prefixIcon: 'assets/svgs/company_icon.svg',
                            hintText: 'Company Name'.tr,
                            visible: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter company name'.tr;
                              } else {
                                return null;
                              }
                            },
                            //suffixIcon: 'assets/eyes.svg',
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: CustommTextField(
                            controller: provider.emailController,
                            prefixIcon: 'assets/email.svg',
                            visible: false,
                            hintText: 'Email'.tr,
                            validator: (value) {
                              bool? v = provider.validate_email_phone(value);
                              if (v == false) {
                                return 'Please enter email'.tr;
                              } else {
                                return null;
                              }
                            },
                            //suffixIcon: 'assets/eyes.svg',
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 6.h,
                                width: 26.w,
                                // margin: EdgeInsets.only(
                                //     bottom: provider.isVisible &&
                                //             provider.phoneController.text.isEmpty
                                //         ? 2.8.h
                                //         : 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17)),
                                child: IntlPhoneField(
                                  controller: provider.phoneController,
                                  focusNode: provider.focusNode,
                                  initialCountryCode: 'AE',
                                  disableAutoFillHints: false,
                                  disableLengthCheck: true,
                                  showDropdownIcon: false,
                                  enabled: false,
                                  flagsButtonMargin:
                                      EdgeInsets.only(left: 3.w, top: 0.3.h),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(17)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(17)),
                                  ),
                                  languageCode: "en",
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                  },
                                  onCountryChanged: (country) {
                                    print(
                                        'Country changed to: ' + country.code);
                                    provider.country_code =
                                        '+' + country.fullCountryCode;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 0.5.h),
                                child: CustommTextField(
                                  hintText: 'e.g 5XXXXXXXX',
                                  visible: false,
                                  controller: provider.phoneController,
                                  //keyboaredType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter phone no'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
