import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

choose_file_option(
    {required Function(File) file,
    required BuildContext context,
    bool? show_file_option = true}) {
  final image_picker = ImagePicker();
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (BuildContext context) {
      return Container(
        height: 20.h,
        width: 100.w,
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final pickedFile = await image_picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  file.call(File(pickedFile.path));
                  Navigator.of(context).pop();
                }
              },
              child: Row(
                children: [
                  Icon(Icons.image_outlined, color: Colors.blueAccent),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    'Choose From Gallery',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            if (show_file_option == true)
              InkWell(
                onTap: () async {
                  FilePickerResult? result =await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    file.call(File(result.files.first.path!));
                    Navigator.of(context).pop();
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.file_copy_outlined, color: Colors.blueAccent),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      'Choose From Files',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(color: Color(0xff181F30)),
      );
    },
  );
}
