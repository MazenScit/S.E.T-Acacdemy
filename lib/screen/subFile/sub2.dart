import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:setacademyapp/Utils/general_URL.dart';
import 'package:setacademyapp/Utils/imageURL.dart';

import '../../Utils/Color.dart';
import '../../controls/get_control.dart';
import '../../model/categories_model.dart';
import '../../model/chapters_model.dart';
import '../../model/my_coursee_model.dart';
import '../../model/subcategories.dart';
import '../chapters/courses.dart';
import '../my_courses/subjectdetails.dart';

class sub2 extends StatefulWidget {
  String id;
  String name;
  sub2({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<sub2> createState() => _sub2State();
}

class _sub2State extends State<sub2> {
  get_Control _get_control = get_Control();
  List<my_coursee_model> _subcategories = [];

  getCategories() {
    _get_control.get_courses(widget.id.toString()).then((value) => setState(() {
          _subcategories = value!;
          isloading = false;
        }));
  }

  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  bool isloading = true;

  @override
  void initState() {
    secure();
    // getCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
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
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        widget.name.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Cobe',
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ))
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
                        : GridView.builder(
                            itemCount: _subcategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: (1.2), crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return items(_subcategories[index]);
                            },
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

  Widget items(my_coursee_model subCat) {
    return InkWell(
      onTap: () {
        // print(subCat.id);

        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return subjectdetails(
        //     courses: subCat,
        //     isShow: true,
        //   );
        // }));
      },
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              subCat.image.toString(),
              height: 100,
            ),
            Text(
              subCat.code.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Cobe', fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
