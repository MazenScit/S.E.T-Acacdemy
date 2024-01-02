import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logale/locale_Cont.dart';
import 'my_courses/my_courses_screen.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  MyLocaleController controller = Get.find();

  check() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final token_User = prefs.get(key);

    if (token_User != null) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return myCourses();
        }), (route) => false);
      });
      print(token_User);
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('login');
      });
    }
  }

  @override
  void initState() {
    // controller.changeLang('en');
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Image.asset('assets/icon/set_logo.png'),
    ));
  }
}
