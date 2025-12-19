import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../global_widgets/custom_button.dart';
import '../../../../../global_widgets/custom_textfield.dart';
import '../../../../../helper/shared_prefs.dart';
import '../../../../global_widgets/data_loading.dart';
import '../../../Authentication Models/login/models/login_Responce_model.dart';
import '../view_model/update_user_profile_provider.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  const UpdateUserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  dynamic formKey = GlobalKey<FormState>();

  @override
  void initState() {
    get_user_info();
    super.initState();
  }

  LoginResponceModel? loginResponceModel;
  get_user_info() async {
    final UpdateUserProfileProvider provider =
        Provider.of<UpdateUserProfileProvider>(context, listen: false);
    SharedPrefs sf = SharedPrefs();
    var data = await sf.getUser();
    loginResponceModel = LoginResponceModel.fromJson(data);
    print('email.......${loginResponceModel?.user?.email}');
    provider.emailController.text = loginResponceModel?.user?.email ?? '';
    provider.first_name_Controller.text =
        loginResponceModel?.user?.firstName ?? '';
    provider.last_name_Controller.text =
        loginResponceModel?.user?.lastName ?? '';
    provider.phoneController.text = loginResponceModel?.user?.phone ?? '';
    provider.loading = false;
    provider.liceince = null;
    provider.logo = null;
    provider.country_code = loginResponceModel?.user?.dialCode ?? '+971';
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
          body: SingleChildScrollView(
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
                          'Update Profile!'.tr,
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
                            InkWell(
                              onTap: () {
                                provider.company_logo();
                              },
                              child: Container(
                                width: 30.w,
                                child: Stack(
                                  children: [
                                    provider.logo == null
                                        ?loginResponceModel==null?SizedBox() :Center(
                                            child: Container(
                                              height: 11.h,
                                              width: 25.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: loginResponceModel!.user!
                                                              .profilePicture !=
                                                          null &&
                                                      loginResponceModel!
                                                          .user!.profilePicture
                                                          .toString()
                                                          .isNotEmpty
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          '${loginResponceModel!.user!.profilePicture}'),
                                                    )
                                                  : Center(
                                                      child: SvgPicture.asset(
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
                            ),
                          ],
                        ),
                      ],
                    ),
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
                          width: 23.w,
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
                                  borderRadius: BorderRadius.circular(17)),
                              fillColor: Colors.white,
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17)),
                            ),
                            languageCode: "en",
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ' + country.code);
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
                  GestureDetector(
                    onTap: () {
                      formKey.currentState!.validate();
                      if (formKey.currentState!.validate()) {
                        provider.call_update_profile(context);
                      }
                    },
                    child: CustomButton(
                      text: 'Update'.tr,
                      borderColor: Color(0xffFFD542),
                      textColor: Color(0xff181F30),
                      buttonColor: Color(0xffFFD542),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
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
