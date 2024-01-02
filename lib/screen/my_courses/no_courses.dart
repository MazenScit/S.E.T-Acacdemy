import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import '../../Utils/Color.dart';
import '../../Utils/imageURL.dart';
import '../courses/courses_screen.dart';

class no_courses extends StatefulWidget {
  const no_courses({Key? key}) : super(key: key);

  @override
  State<no_courses> createState() => _no_coursesState();
}

class _no_coursesState extends State<no_courses> {
  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    secure();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'There are no courses to display'.tr,
            style: TextStyle(
                fontFamily: 'Cobe', fontSize: 18, color: Colors.black),
          ),
          Text(
            'You do not have a subscription to any course'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cobe',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: hi / 20,
          ),
          Image.asset(course),
          SizedBox(
            height: hi / 10,
          ),
          ElevatedButton(
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (context) => DownloadingDialog(
                //       // file: file,
                //       ),
                // );
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Courses();
                }));
              },
              child: Text(
                'Subscribe to a course'.tr,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Cobe',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(width: 1.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(250, 50),
                  primary: Color(Colorbutton))),
        ],
      ),
    );
  }
}
