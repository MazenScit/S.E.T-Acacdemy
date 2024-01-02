import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:setacademyapp/Utils/imageURL.dart';
import 'package:setacademyapp/model/chapters_model.dart';
import 'package:setacademyapp/screen/subFile/subFile.dart';

import '../../Utils/Color.dart';
import '../../controls/get_control.dart';
import '../../model/my_coursee_model.dart';
import '../../model/subcategories.dart';
import '../my_courses/subjectdetails.dart';

class chapters extends StatefulWidget {
  subcategories_model sub;
  chapters({Key? key, required this.sub}) : super(key: key);

  @override
  State<chapters> createState() => _chaptersState();
}

class _chaptersState extends State<chapters> {
  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  get_Control _get_control = get_Control();
  List<my_coursee_model> _chapters = [];
  bool isloading = true;

  getchapters() {
    _get_control
        .get_courses(widget.sub.id.toString())
        .then((value) => setState(() {
              _chapters = value!;
              isloading = false;
            }));
  }

  @override
  void initState() {
    getchapters();
    secure();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.black,
        child: Container(
          color: Colors.red,
          child: SafeArea(
              child: Container(
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
                // Container(
                //   padding: EdgeInsets.only(top: 5),
                //   child: Row(
                //     children: [
                //       IconButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           icon: Icon(Icons.arrow_back_ios))
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: hi / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          )),
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
                    child: isloading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(Colorbutton),
                          ))
                        : Column(
                            children: [
                              Text(widget.sub.name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cobe',
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18)),
                              SizedBox(
                                height: 25,
                              ),
                              Expanded(
                                // height: hi / 1.5,
                                child: ListView.builder(
                                  itemCount: _chapters.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return items(_chapters[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget items(my_coursee_model courses) {
    return Card(
      elevation: 8,
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return subjectdetails(
              my_coursee: courses,
              show: true,
            );
          }));
        },
        title: Text(
          courses.title.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Cobe', fontWeight: FontWeight.bold),
        ),
        leading: Image.asset(
          logo,
          height: 75,
        ),
        trailing: Text(courses.type.toString()),
      ),
    );
  }
}
