import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellowline/helper/navigation/navigation_object.dart';

import 'web_view_global.dart';

List<String> _image_types = [
  'jpg',
  'jpeg',
  'jfif',
  'pjpeg',
  'pjp',
  'png',
  'svg',
  'gif',
  'apng',
  'webp',
  'avif'
];
bool getType_of_url(url) {
  String extension = url.split('.').last;
  if (_image_types.contains(extension)) {
    return true;
  } else {
    return false;
  }
}

Future launch_doc_URL({required String url}) async {
  if (Platform.isIOS) {
    Navigator.push(
        navigationService.navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (c) => WebViewGlobal(
                  url: url,
                  download: true,
                )));
  } else {
    File file = await DownloadService.downloadFile(
        url, DateTime.now().toIso8601String());
    OpenFilex.open("${file.path}");
  }
}

class DownloadService {
  static final _httpClient = HttpClient();

  static Future<File> downloadFile(String url, String filename) async {
    var request = await _httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
