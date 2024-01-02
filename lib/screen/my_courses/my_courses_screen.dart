import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/model/my_coursee_model.dart';
import 'package:setacademyapp/screen/my_courses/no_courses.dart';
import 'package:setacademyapp/screen/my_courses/user_courses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Color.dart';
import '../../Utils/imageURL.dart';
import '../../controls/my_courses/my_courses.dart';
import '../../drawer.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../../logale/locale_Cont.dart';

class myCourses extends StatefulWidget {
  const myCourses({Key? key}) : super(key: key);

  @override
  State<myCourses> createState() => _myCoursesState();
}

class _myCoursesState extends State<myCourses> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;
  bool isLoading = true;
  get_my_courses _get_my_courses = get_my_courses();
  AnimationController? _animationController;
  Animation<double>? _animation1;
  Animation<double>? _animation2;
  Animation<double>? _animation3;
  bool _bool = true;
  List<my_coursee_model> List_my_courses = [];
  Future<void> my_courses() async {
    setState(() {
      isLoading = true;
    });
    _get_my_courses.my_courses().then((value) {
      setState(() {
        List_my_courses = value!;
        isLoading = false;
      });
    });
  }

  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  String? long;
  get_long() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'long';
    long = prefs.get(key).toString();
  }

  MyLocaleController controller = Get.find();
  @override
  void initState() {
    secure();

    my_courses();
    get_long();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _key,
        drawer: Drawer5(),
        body: ColorfulSafeArea(
          color: Color(Colorbutton),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color(Colorbutton),
                  Color(0xFF9573ec),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: hi / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _key.currentState!.openDrawer();
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'My Courses'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Cobe',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset(logo),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: wi,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(50))),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Color(Colorbutton)),
                            )
                          : List_my_courses.isEmpty
                              ? no_courses()
                              : UserCourses(List_Courses: List_my_courses)),
                ),
              ],
            ),
          ),
        ));
  }
}
