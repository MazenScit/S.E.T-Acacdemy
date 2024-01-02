import 'dart:io';

import 'package:dio/dio.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:setacademyapp/Utils/general_URL.dart';

class Download {
  bool state = false;
  get(String url, String name) async {
    Directory _downloadsDirectory;
    String fileurl = url;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      var dir = '/storage/emulated/0/Download/';

      if (dir != null) {
        String savename = name;
        String savePath = dir + "$savename";
        print(savePath);
        print(fileurl);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(fileurl, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
            }
          });
          state = true;
          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    } else {
      print("No permission to read and write.");
    }
  }
}
