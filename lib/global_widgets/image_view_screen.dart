import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final List<String>? imageV;
  final int? slectedIndex;

  ImageView({Key? key, required this.imageV, required this.slectedIndex})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController controller;
  @override
  void initState() {
    int? index = widget.slectedIndex;
    controller = PageController(initialPage: index!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
      body: Container(
        color: Colors.white,
        child: PageView.builder(
          itemCount: widget.imageV!.length,
          controller: controller,
          itemBuilder: (BuildContext context, int itemIndex) {
            return PhotoView(
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              imageProvider: NetworkImage('${widget.imageV![itemIndex]}'),
              backgroundDecoration: BoxDecoration(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
