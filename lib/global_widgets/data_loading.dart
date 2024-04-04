import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final bool? use_opacity;
  const DataLoading(
      {Key? key,
      required this.child,
      required this.isLoading,
      this.use_opacity=true})
      : super(key: key);

  @override
  State<DataLoading> createState() => _DataLoadingState();
}

class _DataLoadingState extends State<DataLoading>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        widget.child,
        widget.isLoading
            ? Container(
                width: size.width,
                height: size.height,
                color:!widget.use_opacity!?null: Colors.white.withOpacity(0.2),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitDoubleBounce(
                      color: Colors.grey,
                      size: 25.0,
                    )
                  ],
                ))
            : const SizedBox()
      ],
    );
  }
}
