import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:setacademyapp/controls/user_control.dart';
import 'package:setacademyapp/model/my_coursee_model.dart';
import 'package:setacademyapp/screen/my_courses/no_courses.dart';
import 'package:setacademyapp/screen/my_courses/user_courses.dart';
import 'package:setacademyapp/screen/sendmessagesystem/controller/uaecontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Color.dart';
import '../../Utils/imageURL.dart';
import '../../controls/my_courses/my_courses.dart';
import '../../drawer.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../../logale/locale_Cont.dart';
import '../screen/sendmessagesystem/controller/sendmessagecontroller.dart';

class send_code_page extends StatefulWidget {
  String phone;
  String fnameController;
  String mnameController;
  String lnameController;
  String phoneController;
  String passwordController;
  String emailController;
  String governorate;
  String addressController;
  String specialization;
  String universitie;
  String graduated;
  String year;
  String deviceToken;
  send_code_page(
      {Key? key,
      required this.phone,
      required this.addressController,
      required this.deviceToken,
      required this.emailController,
      required this.fnameController,
      required this.governorate,
      required this.graduated,
      required this.lnameController,
      required this.mnameController,
      required this.passwordController,
      required this.phoneController,
      required this.specialization,
      required this.universitie,
      required this.year})
      : super(key: key);

  @override
  State<send_code_page> createState() => _send_code_pageState();
}

String mycode = "";
UaeController _myUaeController=UaeController();


class _send_code_pageState extends State<send_code_page> {
  get_pass(){
     sendmessage(widget.phoneController).then((value){
          mycode=value;
     });
}
  @override
  void initState() {
    get_pass();
    // TODO: implement initState
    super.initState();
  }

  OtpFieldController otpController = OtpFieldController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Color primary = Colors.white;
  TextEditingController CodeController = TextEditingController();
  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;
  bool isLoading = true;
  get_my_courses _get_my_courses = get_my_courses();
  User_Control _user_control = User_Control();
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
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ColorfulSafeArea(
      color: Color(Colorbutton),
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
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios))
                ],
              ),
            ),
            SizedBox(
              height: hi / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Code activation'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75,
                        ),
                        // Center(
                        //   child: Container(
                        //     height: 50,
                        //     width: 250,
                        //     child: TextFormField(
                        //       textAlign: TextAlign.center,
                        //       keyboardType: TextInputType.number,
                        //       cursorColor: Colors.black,
                        //       controller: CodeController,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.white,
                        //         enabledBorder: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(8),
                        //             borderSide:
                        //                 BorderSide(color: Color(0xff34196b))),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(8),
                        //             borderSide:
                        //                 BorderSide(color: Color(0xFF9C8FB4))),
                        //         hintText: 'code'.tr,
                        //         hintStyle: TextStyle(
                        //             color: Color(0xff8c9289),
                        //             fontFamily: 'Cobe'),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text(
                          'Code enter'.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Cobe',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        OTPTextField(
                            controller: otpController,
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 15,
                            style: TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              print(mycode);
                              print(pin);
                              if (mycode == pin) {
                                _user_control.register(
                                    widget.fnameController,
                                    widget.mnameController,
                                    widget.lnameController,
                                    widget.phoneController,
                                    widget.passwordController,
                                    widget.emailController,
                                    widget.governorate,
                                    widget.addressController,
                                    widget.specialization,
                                    widget.universitie,
                                    widget.graduated,
                                    widget.year,
                                    widget.deviceToken,
                                    context);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.bottomSlide,
                                  title: 'The code is incorrect'.tr,
                                  // btnOkOnPress: () {},
                                ).show();
                              }
                            }),

                        // ElevatedButton(
                        //     onPressed: () {

                        //       _user_control.verify_code(
                        //           widget.fnameController,
                        //           widget.mnameController,
                        //           widget.lnameController,
                        //           widget.phone,
                        //           widget.passwordController,
                        //           widget.emailController,
                        //           widget.governorate,
                        //           widget.addressController,
                        //           widget.specialization,
                        //           widget.universitie,
                        //           widget.graduated,
                        //           widget.year,
                        //           widget.deviceToken,
                        //           CodeController.text.toString(),
                        //           context);
                        //     },
                        //     child: Text(
                        //       'Code activation'.tr,
                        //       style: TextStyle(
                        //           fontSize: 17,
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(
                        //             // side: BorderSide(width: 1.0, color: Colors.black),
                        //             borderRadius: BorderRadius.circular(15)),
                        //         minimumSize: const Size(250, 50),
                        //         primary: Color(Colorbutton))),
                      ],
                    ))),
          ],
        ),
      ),
    ));
  }
}
