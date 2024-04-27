import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshControllerGlobal extends StatefulWidget {
  final Widget? child;
  final Function()? onRefresh;
  final Function()? onLoad;
  final RefreshController? controller;

  const RefreshControllerGlobal(
      {Key? key, this.child, this.onRefresh, this.onLoad, this.controller})
      : super(key: key);

  @override
  _RefreshControllerGlobalState createState() =>
      _RefreshControllerGlobalState();
}

class _RefreshControllerGlobalState extends State<RefreshControllerGlobal> {
  void _onRefresh() async {
    await widget.onRefresh!.call();
  }

  void _onLoading() async {
    await widget.onLoad!.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(
          distance: 40,
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget? body;
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        physics: BouncingScrollPhysics(),
        controller: widget.controller!,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: widget.child!,
      ),
    );
  }
}