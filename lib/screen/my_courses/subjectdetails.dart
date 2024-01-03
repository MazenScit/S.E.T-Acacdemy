import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' ;
import 'package:setacademyapp/Utils/general_URL.dart';
import 'package:setacademyapp/auth/sign_up.dart';
import 'package:setacademyapp/controls/comments/comments_control.dart';
import 'package:setacademyapp/model/comment_model.dart';
import 'package:setacademyapp/model/review_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Color.dart';
import '../../controls/get_control.dart';
import '../../controls/requests_courses/requests_courses.dart';
import '../../controls/review/review_Control.dart';
import '../../model/chapters_model.dart';
import '../../model/my_coursee_model.dart';
import '../../model/techersmodel.dart';
import '../Content/Content.dart';
import 'package:image_picker/image_picker.dart';

class subjectdetails extends StatefulWidget {
  my_coursee_model my_coursee;
  bool? show;
  subjectdetails({Key? key, required this.my_coursee, required this.show})
      : super(key: key);

  @override
  State<subjectdetails> createState() => _SearchState();
}

bool isLoading = false;

bool isLoadingchapters = false;

class _SearchState extends State<subjectdetails>
    with SingleTickerProviderStateMixin {
  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  TextEditingController comments_Cont = TextEditingController();
  TextEditingController review_Cont = TextEditingController();

  comments_control _comments = comments_control();

  XFile? pickedFile;
  File? imageFile;
  var token_User;
  check() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    token_User = prefs.get(key);
  }

  TabController? _tabController;
  requests_courses _requests_courses = requests_courses();
  TextEditingController Code_Cont = TextEditingController();
  get_Control controller = get_Control();
  review_Control _review_control = review_Control();
  List<techers_model> teachers = [];
  List<courses_model> chapters = [];
  List<comment_model> comments = [];
  List<review_model> reviews = [];
  int rate = 3;
  var transformation;
  get_comments() {
    controller.get_comments(widget.my_coursee.id).then((value) {
      comments = value!;
      setState(() {
        isLoading = true;
      });
    });
  }

  get_reviews() {
    controller.get_reviews(widget.my_coursee.id).then((value) {
      reviews = value!;
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    check();
    get_comments();
    get_reviews();
    secure();
    controller.get_chapter(widget.my_coursee.id).then((value) {
      chapters = value!;
      setState(() {
        isLoading = true;
      });
    });
    controller.get_techers(widget.my_coursee.id).then((value) {
      teachers = value!;
      setState(() {
        isLoadingchapters = true;
      });
    });
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back,
                    ),
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${widget.my_coursee.image}'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    widget.my_coursee.title.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cobe',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('hour'.tr),
                    Text(
                      " ${widget.my_coursee.hours.toString()}",
                      style: TextStyle(
                        fontFamily: 'Cobe',
                      ),
                    ),
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colorbutton,
                      size: 15,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Chapter'.tr),
                    Text(
                      " ${widget.my_coursee.chapters_count.toString()}",
                      style: TextStyle(
                        fontFamily: 'Cobe',
                      ),
                    ),
                    Icon(
                      Icons.book_sharp,
                      color: Colorbutton,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colorbutton,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: double.infinity,
                height: 35,
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 12),
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Comments".tr,
                    ),
                    Tab(
                      text: "Ratings".tr,
                    ),
                    Tab(
                      text: "Chapters".tr,
                    ),
                    Tab(
                      text: "Teachers".tr,
                    ),
                  ],
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  comments.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              comment(),
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text('There are no data'.tr),
                            widget.show == true
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          actions: [
                                                            contact_us(context)
                                                          ],
                                                        ));
                                          },
                                          child: Icon(Icons.edit),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  // side: BorderSide(width: 1.0, color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              minimumSize: const Size(50, 50),
                                              primary: Colorbutton)),
                                    ],
                                  )
                          ],
                        )),
                  reviews.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              review(),
                              widget.show == true
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        actions: [
                                                          contact_us(context)
                                                        ],
                                                      ));
                                            },
                                            child: Icon(Icons.edit),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    // side: BorderSide(width: 1.0, color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                minimumSize: const Size(50, 50),
                                                primary: Colorbutton)),
                                      ],
                                    ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Center(child: Text('There are no data'.tr)),
                            widget.show == true
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          actions: [
                                                            add_review(context)
                                                          ],
                                                        ));
                                          },
                                          child: Icon(Icons.edit),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  // side: BorderSide(width: 1.0, color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              minimumSize: const Size(50, 50),
                                              primary: Colorbutton)),
                                    ],
                                  ),
                          ],
                        ),
                  chapters.isNotEmpty
                      ? chapter()
                      : Center(child: Text('There are no data'.tr)),
                  teachers.isNotEmpty
                      ? teacher()
                      : Center(
                          child: Text(
                          'There are no data'.tr,
                        )),
                ],
                controller: _tabController,
              ),
            ),
            widget.show == true
                ? InkWell(
                    onTap: () {
                      token_User == null
                          ? {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.noHeader,
                                animType: AnimType.bottomSlide,
                                title: 'You do not have an account'.tr,
                                desc: 'Please create an account'.tr,
                                btnOkOnPress: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return sgin_up();
                                    },
                                  ), (route) => false);
                                },
                              ).show()
                            }
                          : {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return SingleChildScrollView(
                                      // controller:
                                      //     ModalScrollController.of(context),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: 55,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                'Please select a payment process'
                                                    .tr),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Radio(
                                                      activeColor:
                                                          Colorbutton,
                                                      value: 'Bank',
                                                      groupValue:
                                                          transformation,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          transformation =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    Text('Bank'.tr),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                      activeColor:
                                                          Colorbutton,
                                                      value: 'Coupon',
                                                      groupValue:
                                                          transformation,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          transformation =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                    Text('Coupon'.tr),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            transformation == 'Bank'
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _getFromcamera();
                                                    },
                                                    child: Text(
                                                      'Add image'.tr,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    // side: BorderSide(width: 1.0, color: Colors.black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            minimumSize:
                                                                const Size(
                                                                    250, 50),
                                                            primary: 
                                                                Colorbutton))
                                                : Container(
                                                    height: 50,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      // textAlign: TextAlign.center,

                                                      keyboardType:
                                                          TextInputType.text,
                                                      cursorColor: Colors.black,
                                                      controller: Code_Cont,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xff34196b))),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xFF9C8FB4))),
                                                              label: Text(
                                                                  'Enter Code'),
                                                              labelStyle: TextStyle(
                                                                  color: Colors
                                                                      .black54)),
                                                    ),
                                                  ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            transformation == 'Bank'
                                                ? SizedBox()
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      _requests_courses
                                                          .send_code(
                                                              widget
                                                                  .my_coursee.id
                                                                  .toString(),
                                                              Code_Cont.text
                                                                  .toString(),
                                                              context);
                                                    },
                                                    child: Text(
                                                      'Verification'.tr,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    // side: BorderSide(width: 1.0, color: Colors.black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            minimumSize:
                                                                const Size(
                                                                    150, 50),
                                                            primary: 
                                                                Colorbutton))
                                          ],
                                        ),
                                      ));
                                }),
                              ),
                              // showDialog<void>(
                              //   context: context,
                              //   barrierDismissible: true,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title:

                              //       content: SingleChildScrollView(
                              //         child:

                              //   },
                              // )
                            };
                      // _requests_courses.Send_image(
                      //     widget.my_coursee.id.toString(),'', context);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Course request".tr,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                " ${widget.my_coursee.price}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                apiacceptencevariable.toString()!="0"?
                                " sp".tr:" \$",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colorbutton,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(5),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget comment() {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
              color: Colors.white,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Text(
                      comments[index].name_user.toString(),
                    ),
                    subtitle: Text(comments[index].comment.toString()),
                  ));
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            actions: [contact_us(context)],
                          ));
                },
                child: Icon(Icons.edit),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: const Size(50, 50),
                    primary: Colorbutton)),
          ],
        )
      ],
    );
  }

  Center teacher() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 545,
        child: ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                title: Text(
                  teachers[index].first_name,
                  textAlign: TextAlign.right,
                ),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage(teachers[index].image),
                ),
              ));
            }),
      ),
    );
  }

  Center chapter() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 545,
        child: ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Content(
                              courses: chapters[index], show: widget.show!);
                        }));
                      },
                      title: Text(
                        chapters[index].title.toString(),
                        textAlign: TextAlign.right,
                      ),
                      trailing: chapters[index].image == null
                          ? SizedBox()
                          : Image.network(
                              imageUrl + chapters[index].image,
                              width: 50,
                            )));
            }),
      ),
    );
  }

  Container add_review(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            maxLines: 8,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            controller: review_Cont,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff34196b))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF9C8FB4))),
              hintText: 'Enter the comments'.tr,
              hintStyle:
                  TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              rate = rating.toInt();
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _review_control
                  .add_review(widget.my_coursee.id.toString(),
                      review_Cont.text.toString(), rate.toString(), context)
                  .whenComplete(() {
                Navigator.of(context, rootNavigator: true).pop();
                review_Cont.text = '';
              });
            },
            child: Text(
              'Send'.tr,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    // side: BorderSide(width: 2.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(90, 50),
                primary: Colorbutton),
          )
        ],
      ),
    );
  }

  Container contact_us(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            maxLines: 8,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            controller: comments_Cont,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xff34196b))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF9C8FB4))),
              hintText: 'Enter the comments'.tr,
              hintStyle:
                  TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _comments
                  .add_comments(widget.my_coursee.id.toString(),
                      comments_Cont.text.toString(), context)
                  .whenComplete(
                      () => Navigator.of(context, rootNavigator: true).pop());
              comments_Cont.text = '';
            },
            child: Text(
              'Send'.tr,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    // side: BorderSide(width: 2.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(90, 50),
                primary: Colorbutton),
          )
        ],
      ),
    );
  }

  Center review() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                title: Text(
                  reviews[index].name_user.toString(),
                ),
                subtitle: Text(
                  reviews[index].message.toString(),
                ),
                trailing: RatingBarIndicator(
                  rating: double.parse("${reviews[index].rate}"),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ));
            }),
      ),
    );
  }

  _getFromcamera() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      print(imageFile);
      _requests_courses.Send_image(
          imageFile!, widget.my_coursee.id, Code_Cont.text.toString(), context);
    }
  }
}
