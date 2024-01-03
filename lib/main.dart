
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/auth/log_in.dart';
import 'package:setacademyapp/screen/sendmessagesystem/controller/uaecontroller.dart';
import 'package:setacademyapp/screen/welcome.dart';
import 'logale/locale_Cont.dart';
import 'logale/logale.dart';
import 'screen/splash.dart';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return GetMaterialApp(
      translations: MyLocale(),
      theme: ThemeData(
        fontFamily: 'Cobe',
      ),
      debugShowCheckedModeBanner: false,
      home: WalkThroughScreen(),
      routes: {
        'login': ((context) => login()),
      },
    );
  }
}
