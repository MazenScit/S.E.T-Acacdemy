import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/logale/locale_Cont.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Color.dart';
import '../controls/user_control.dart';
import '../screen/courses/courses_screen.dart';
import 'sign_up.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  bool _isHiddenPassword = true;

  User_Control _user_control = User_Control();
  MyLocaleController controller = Get.find();

  var deviceToken;
  gettoken() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      String deviceId = androidDeviceInfo.id;
      String deviceModel = androidDeviceInfo.model;
      String deviceManufacturer = androidDeviceInfo.manufacturer;
      deviceToken = deviceId + deviceModel + deviceManufacturer;
    } else if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      String? deviceId = iosDeviceInfo.identifierForVendor;
      String? deviceModel = iosDeviceInfo.model;
      String deviceManufacturer = "Apple";
      deviceToken = deviceId! + deviceModel! + deviceManufacturer;
    }
  }

  @override
  void initState() {
    get_long();
    gettoken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
        
          height: hi,
          width: wi,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 233, 215, 241),
              Color.fromARGB(255, 255, 255, 255),
            ],
          )),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: hi / 200,
              ),
              Image.asset('assets/images/welcome/set_1.png'),
              SizedBox(
                height: hi / 50,
              ),
              Row(
                children: [
                  Text(
                    'LOG IN'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Cobe'),
                  ),
                ],
              ),
              SizedBox(
                height: hi / 50,
              ),
              SizedBox(
                height: hi / 50,
              ),
              form(PhoneController, 'Phone'.tr, TextInputType.phone),
              SizedBox(
                height: hi / 50,
              ),
              form(
                  PassController, 'password'.tr, TextInputType.visiblePassword),
              SizedBox(
                height: hi / 20,
              ),
              button('LOG IN'.tr),
              SizedBox(
                height: hi / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue as".tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cobe'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Courses();
                        }));
                      },
                      child: Text(
                        'a Guest'.tr,
                        style: TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Color(0xff34196b),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cobe'),
                      )),
                ],
              ),
              // SizedBox(
              //   height: ,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?".tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cobe'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return sgin_up();
                        }));
                      },
                      child: Text(
                        'Sign Up'.tr,
                        style: TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Color(0xff34196b),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cobe'),
                      )),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          child: TextFormField(
            // textAlign: TextAlign.center,
            obscureText: type == TextInputType.visiblePassword
                ? _isHiddenPassword
                : false,
            keyboardType: type,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: InputDecoration(
              suffixIcon: type != TextInputType.visiblePassword
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _isHiddenPassword = !_isHiddenPassword;
                        });
                      },
                      child: Icon(
                        _isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color.fromARGB(228, 164, 1, 170),
                      ),
                    ),
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
              hintText: Title,
              hintStyle:
                  TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
            ),
          ),
        ),
      ],
    );
  }

  get_long() async {
    final prefs = await SharedPreferences.getInstance();
    final long = prefs.get('long');
    if (long == null) {
      controller.changeLang('en');
      _save('en');
    } else {
      controller.changeLang(long.toString());
    }
  }

  Column button(String title) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              loginUser();
            },
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    // side: BorderSide(width: 1.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                minimumSize: const Size(250, 50),
                primary: Colorbutton)),
      ],
    );
  }

  _save(String long) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'long';
    final value = long;

    prefs.setString(key, value);
    print('done...22' + long);
  }

  void loginUser() async {
    String _Phone = PhoneController.text.trim();
    String _password = PassController.text.trim();

    if (_Phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PHONE MUST BE REQUIRED'.tr),
        backgroundColor: Colors.red,
      ));
    } else if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PASSWORD MUST BE REQUIRED'.tr),
        backgroundColor: Colors.red,
      ));
    } else {
      _user_control.login(context, _Phone, _password, deviceToken);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) {
      //   return home(
      //     type: type.toString(),
      //   );
      // }));
    }
  }
}
