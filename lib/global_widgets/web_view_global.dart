import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewGlobal extends StatefulWidget {
  final String? url;
  final String? title;
  final bool? download;
  const WebViewGlobal({
    Key? key,
    this.url,
    this.title = '',
    this.download = false,
  }) : super(key: key);

  @override
  State<WebViewGlobal> createState() => _WebViewGlobalState();
}

class _WebViewGlobalState extends State<WebViewGlobal> {
  WebViewController _controller = WebViewController();
  @override
  void initState() {
    print('url invoice = ${widget.url}');
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print('completed');
            load = true;
            setState(() {});
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }

  bool load = false;
  var httpClient = new HttpClient();
  Future<File?> _downloadFile({String? url, String? filename}) async {
    var request = await httpClient.getUrl(Uri.parse(url!));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      Directory? tempDir = await getApplicationDocumentsDirectory();
      File file = new File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      //snackBarFailer('Storage Permission denied');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(widget.title!, style: TextStyle(color: Colors.black)),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: [
              if (widget.download!)
                IconButton(
                    onPressed: () async {
                      File? file = await _downloadFile(
                          url: '${widget.url}',
                          filename: '${widget.title}.pdf');
                      if (file != null) {
                        print(file.path);
                        await SharePlus.instance.share(ShareParams(
                          text: '',
                          files: [XFile('${file.path}')],
                        ));
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.share,
                      color: Colors.blue,
                    ))
            ]),
        backgroundColor: Colors.white,
        body: Container(
          width: 100.w,
          height: 100.h,
          color: Colors.white,
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              // WebView(
              //   initialUrl: Uri.parse('${widget.url}').toString(),
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onWebViewCreated: (WebViewController webViewController) {
              //     _controller.complete(webViewController);
              //   },
              //   onPageFinished: (v) {
              //     print('completed');
              //     load = true;
              //     setState(() {});
              //   },
              // ),
              if (!load)
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ));
  }
}
