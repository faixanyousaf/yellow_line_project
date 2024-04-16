import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'custom_textfield.dart';

Future listBottomSheet(
    {required BuildContext? context,
    required Function()? add_new,
    required Function(List<String>)? selected_values,
    required List<String>? all_values,
    required List<String>? pre_selected_all_values,
    required bool hide_add_new,
    bool? disable_search = false}) async {
  List<String> list_selected_value = [...pre_selected_all_values!];
  String search = '';
  await showMaterialModalBottomSheet(
    context: context!,
    backgroundColor: Color(0xffFFD542).withOpacity(0.2),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Container(
            color: Color(0xffFFD542).withOpacity(0.2),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 60.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Color(0xff181F30),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Container(
                          height: 0.5.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: BorderRadius.circular(30))),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 1.5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/svgs/undo.svg',
                                color: Colors.white,
                              ),
                            ),
                            if (!hide_add_new)
                              Row(
                                children: [
                                  Text(
                                    'Add New',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Aveni_Next',
                                        fontSize: 12.sp),
                                  ),
                                  SizedBox(width: 3.w),
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 7.w),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(
                                0xffDAF1F4,
                              )),
                          child: Column(
                            children: [
                              if (disable_search == false)
                                SizedBox(
                                  height: 2.h,
                                ),
                              if (disable_search == false)
                                CustommTextField(
                                  //controller: provider.emailController,
                                  prefixIcon: 'assets/svgs/search.svg',
                                  hintText: 'Search',
                                  onChange: (v) {
                                    search = v;
                                    setState(() {});
                                  },
                                ),
                              Expanded(
                                child: ListView.builder(
                                    itemBuilder: (c, i) {
                                      if (search.isEmpty) {
                                        return InkWell(
                                          onTap: () {
                                            if (all_values.length > 1) {
                                              if (list_selected_value.contains(
                                                  '${all_values![i]}')) {
                                                list_selected_value.remove(
                                                    '${all_values![i]}');
                                              } else {
                                                list_selected_value = [];
                                                list_selected_value
                                                    .add('${all_values![i]}');
                                              }
                                              setState(() {});
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Row(
                                                children: [
                                                  list_selected_value.contains(
                                                          '${all_values![i]}')
                                                      ? SvgPicture.asset(
                                                          'assets/svgs/tick.svg')
                                                      : SvgPicture.asset(
                                                          'assets/svgs/tick_square_empty.svg'),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Text(
                                                    '${all_values![i]}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Aveni_Next',
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Divider(
                                                thickness: 1,
                                                color:
                                                    Colors.grey.withAlpha(100),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        if (all_values![i]
                                            .toString()
                                            .toLowerCase()
                                            .contains(search.toLowerCase())) {
                                          return InkWell(
                                            onTap: () {
                                              if (list_selected_value.contains(
                                                  '${all_values![i]}')) {
                                                list_selected_value.remove(
                                                    '${all_values![i]}');
                                              } else {
                                                list_selected_value = [];
                                                list_selected_value
                                                    .add('${all_values![i]}');
                                              }
                                              setState(() {});
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Row(
                                                  children: [
                                                    list_selected_value.contains(
                                                            '${all_values![i]}')
                                                        ? SvgPicture.asset(
                                                            'assets/svgs/tick.svg')
                                                        : SvgPicture.asset(
                                                            'assets/svgs/tick_square_empty.svg'),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    Text(
                                                      '${all_values![i]}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Aveni_Next',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.grey
                                                      .withAlpha(100),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                      return SizedBox();
                                    },
                                    itemCount: all_values?.length ?? 0,
                                    padding: EdgeInsets.zero),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: InkWell(
                          onTap: () {
                            if (list_selected_value.isNotEmpty) {
                              selected_values!.call(list_selected_value);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            height: 7.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffFFD542)),
                            child: Center(
                              child: Text(
                                'Proceed',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ]),
                  ),
                ),
              ],
            ));
      },
    ),
  );
}
