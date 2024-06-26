import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown2 extends StatefulWidget {
  final List<String> list_items;
  final Function(int) selected_index;
  final String? hint;
  final String? initial_value;
  final Offset? offset;
  final double? drop_down_width;
  final String? prefix_icon;
  final Color? prefix_icon_color;
  final Color? drop_down_box_color;
  final double? hint_font_size;
  final bool? hint_font_weight;
  const CustomDropDown2(
      {Key? key,
      required this.list_items,
      required this.selected_index,
      required this.hint,
      required this.initial_value,
      this.offset = const Offset(-8, -10),
      this.drop_down_width,
      this.prefix_icon,
      this.prefix_icon_color,
      this.hint_font_size,
      this.hint_font_weight = false,
      this.drop_down_box_color})
      : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  String? initial_value;
  @override
  void initState() {
    initial_value = widget.initial_value!.isEmpty ? null : widget.initial_value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          '${widget.hint}',
          style: TextStyle(
              color: Colors.black,
              fontSize: widget.hint_font_size ?? 10.sp,
              fontWeight: widget.hint_font_weight! ? FontWeight.bold : null),
          overflow: TextOverflow.ellipsis,
        ),
        items: widget.list_items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.hint_font_size ?? 9.sp,
                        fontWeight:
                            widget.hint_font_weight! ? FontWeight.bold : null),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: initial_value,
        onChanged: (value) {
          initial_value = value!;
          setState(() {});
          int index = widget.list_items.indexOf(value);
          widget.selected_index.call(index);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          //padding: const EdgeInsets.only(left: 14, right: 14),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 14,
          iconEnabledColor: Colors.blue,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
            maxHeight: 500,
            width: widget.drop_down_width == null
                ? MediaQuery.of(context).size.width - 60
                : widget.drop_down_width!,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.drop_down_box_color ?? Color(0xffe9e8ff),
            ),
            elevation: 8,
            offset: widget.offset!,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
