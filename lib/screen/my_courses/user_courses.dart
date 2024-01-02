import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/model/my_coursee_model.dart';
import 'package:setacademyapp/screen/my_courses/my_courses_screen.dart';
import 'package:setacademyapp/screen/my_courses/subjectdetails.dart';

import '../../Utils/Color.dart';
import '../courses/courses_screen.dart';

class UserCourses extends StatefulWidget {
  List<my_coursee_model> List_Courses = [];
  UserCourses({Key? key, required this.List_Courses}) : super(key: key);

  @override
  State<UserCourses> createState() => _UserCoursesState();
}

class _UserCoursesState extends State<UserCourses> {
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
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: hi / 1.5,
            child: GridView.builder(
              itemCount: widget.List_Courses.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (1.2), crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                List<my_coursee_model> my_Coueses_item = widget.List_Courses;
                return items(my_Coueses_item[index]);
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
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
                  primary: Color(Colorbutton)))
        ],
      ),
    );
  }

  Widget items(my_coursee_model my_Courses) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return subjectdetails(
            my_coursee: my_Courses,
            show: false,
          );
        }));
      },
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              my_Courses.image.toString(),
              height: 100,
            ),
            Text(
              my_Courses.title.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Cobe', fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
