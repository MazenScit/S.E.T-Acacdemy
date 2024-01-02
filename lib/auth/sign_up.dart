import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:setacademyapp/Utils/general_URL.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/auth/send_code_page.dart';
import 'package:setacademyapp/controls/get_control.dart';
import '../Utils/Color.dart';
import '../controls/user_control.dart';
import '../model/governorates.dart';
import '../model/specializations.dart';
import '../model/universities.dart';
import 'val.dart';

class sgin_up extends StatefulWidget {
  sgin_up({Key? key}) : super(key: key);

  @override
  State<sgin_up> createState() => _sgin_upState();
}

class _sgin_upState extends State<sgin_up> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // FirebaseAuth auth = FirebaseAuth.instance;
  String year = '1';
  var group;
  bool istrue = false;
  String graduated = '1';
  List<Mgovernorates>? Lgovernorates = [];
  var governorate;

  List<Mspecializations>? Lspecializations = [];
  var specialization;

  List<Muniversities>? Luniversities = [];
  var universitie;

  String? deviceToken;
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

  List<String> Lyear = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  get_Control _get_control = get_Control();

  val _vre = val();
  User_Control _user_control = User_Control();

  getgovernorate() {
    _get_control.get_governorates().then((value) => setState(() {
          Lgovernorates = value!;
        }));
  }

  getspecialization() {
    _get_control.get_specializations().then((value) => setState(() {
          Lspecializations = value!;
        }));
  }

  getuniversitie() {
    _get_control.get_universities().then((value) => setState(() {
          Luniversities = value!;
        }));
  }

  @override
  void initState() {
    gettoken();
    getgovernorate();
    getuniversitie();
    getspecialization();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: hi,
            width: wi,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
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
                  Image.asset(
                    'assets/images/welcome/set_1.png',
                    height: 200,
                  ),
                  Row(
                    children: [
                      Text(
                        'Create an Account'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: hi / 50,
                  ),
                  form(fnameController, 'First Name'.tr, TextInputType.name),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(mnameController, 'Middle Name'.tr, TextInputType.name),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(lnameController, 'Last Name'.tr, TextInputType.name),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(phoneController, 'Phone'.tr, TextInputType.phone),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(passwordController, 'Password'.tr,
                      TextInputType.visiblePassword),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(passwordConfController, 'Password confirmation'.tr,
                      TextInputType.visiblePassword),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(emailController, 'Email'.tr, TextInputType.emailAddress),
                  SizedBox(
                    height: hi / 70,
                  ),
                  Column(
                    children: [
                      apiacceptencevariable.toString()!="0"?
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0xff34196b))),
                        child: DropdownButton<dynamic>(
                          items: Lgovernorates!
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.name.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cobe',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    value: e.id,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              governorate = newValue;
                            });
                          },
                          isExpanded: true,
                          hint: Container(
                            margin: EdgeInsets.all(8),
                            child: Text(
                              'Governorate'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cobe',
                                  fontSize: 16,
                                  color: Colors.black45),
                            ),
                          ),
                          value: governorate,
                          icon: Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0xff34196b)),
                        ),
                      ):SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: hi / 70,
                  ),
                  form(addressController, 'Address'.tr, TextInputType.name),
                  SizedBox(
                    height: hi / 70,
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0xff34196b))),
                        child: DropdownButton<dynamic>(
                          items: Lspecializations!
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.name.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cobe',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    value: e.id,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              specialization = newValue;
                            });
                          },
                          isExpanded: true,
                          hint: Container(
                            margin: EdgeInsets.all(8),
                            child: Text(
                              'Specializations'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cobe',
                                  fontSize: 16,
                                  color: Colors.black45),
                            ),
                          ),
                          value: specialization,
                          icon: Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0xff34196b)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: hi / 70,
                  ),
                  Column(
                    children: [
                      apiacceptencevariable.toString()!="0"?
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Color(0xff34196b))),
                        child: DropdownButton<dynamic>(
                          items: Luniversities!
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.name.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Cobe',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    value: e.id,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              universitie = newValue;
                            });
                          },
                          isExpanded: true,
                          hint: Container(
                            margin: EdgeInsets.all(8),
                            child: Text(
                              'Universities'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cobe',
                                  fontSize: 16,
                                  color: Colors.black45),
                            ),
                          ),
                          value: universitie,
                          icon: Icon(Icons.keyboard_arrow_down_outlined,
                              color: Color(0xff34196b)),
                        ),
                      ):SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: hi / 70,
                  ),
                  SizedBox(
                    height: hi / 70,
                  ),
                  Row(
                    children: [
                      Text(
                        'Are you graduated ?'.tr,
                        style: TextStyle(
                            fontFamily: 'Cobe',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SystemOrExpert(),
                  SizedBox(
                    height: hi / 80,
                  ),
                  group == 'NO'.tr
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Color(0xff34196b))),
                              child: DropdownButton<dynamic>(
                                items: Lyear.map((e) => DropdownMenuItem(
                                      child: Text(
                                        e.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cobe',
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      value: e,
                                    )).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    year = newValue;
                                  });
                                },
                                isExpanded: true,
                                hint: Container(
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    'Year'.tr,
                                    style: TextStyle(
                                        fontFamily: 'Cobe',
                                        fontSize: 16,
                                        color: Colors.black45),
                                  ),
                                ),
                                value: year,
                                icon: Icon(Icons.keyboard_arrow_down_outlined,
                                    color: Color(0xff34196b)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: hi / 80,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Color(Colorbutton),
                        value: istrue,
                        onChanged: (value) {
                          setState(() {
                            istrue = value!;
                          });
                        },
                      ),
                      Text('Do you agree'.tr),
                      TextButton(
                          onPressed: () {
                            launcher.launch(
                                "https://docs.google.com/document/d/1_Z7lXOV2Cy9HjKiyqOsO_O22z7G-F8Lmp79GL4SsvKs/edit?usp=sharing");
                          },
                          child: Text(
                            'Terms and Conditions'.tr,
                            style: TextStyle(
                                color: Color(Colorbutton),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  istrue == true
                      ? ElevatedButton(
                          onPressed: () {
                            if (passwordController.text
                                    .toString()
                                    .trim()
                                    .length <
                                8) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'The password must be at least 8 characters'
                                        .tr),
                                backgroundColor: Colors.red,
                              ));
                            } else if (passwordController.text
                                    .toString()
                                    .trim() !=
                                passwordConfController.text.toString().trim()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('password does not match'.tr),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //   return send_code_page(
                              //     phone: phoneController.text.toString(),
                              //     addressController:
                              //         addressController.text.toString(),
                              //     deviceToken: deviceToken.toString(),
                              //     emailController:
                              //         emailController.text.toString(),
                              //     fnameController:
                              //         fnameController.text.toString(),
                              //     governorate: governorate.toString(),
                              //     graduated: graduated.toString(),
                              //     lnameController:
                              //         lnameController.text.toString(),
                              //     mnameController:
                              //         mnameController.text.toString(),
                              //     passwordController:
                              //         passwordConfController.text.toString(),
                              //     phoneController:
                              //         phoneController.text.toString(),
                              //     specialization: specialization.toString(),
                              //     universitie: universitie.toString(),
                              //     year: year.toString(),
                              //   );
                              // }));
                              // _user_control.send_code(
                              //     phoneController.text.toString(), context);
                              //   print(universitie);
                              //   print(specialization);
                              //   print(governorate);
                              //   print(fnameController.text);

                              //   print('aaaaa' + mnameController.text);

                              //   print(lnameController.text);
                              //   print(phoneController.text);
                              //   print('1111' + passwordController.text);
                              //   print(emailController.text);
                              //   print(addressController.text);
                              //   print(graduated);
                              //   print(deviceToken);
                              _user_control.register(
                                  fnameController.text.toString(),
                                  mnameController.text.toString(),
                                  lnameController.text.toString(),
                                  phoneController.text.toString(),
                                  passwordController.text.toString(),
                                  emailController.text.toString(),
                                  "2",
                                  addressController.text.toString(),
                                  specialization.toString(),
                                  "2",
                                  graduated.toString(),
                                  year.toString(),
                                  deviceToken.toString(),
                                  context);
                            }
                          },
                          child: Text(
                            'Sign Up'.tr,
                            style: TextStyle(
                                fontFamily: 'Cobe',
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              minimumSize: const Size(double.infinity, 50),
                              primary: Color(0xff34196b)))
                      : ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Sign Up'.tr,
                            style: TextStyle(
                                fontFamily: 'Cobe',
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2.0, color: Color(0xFF767479)),
                                  borderRadius: BorderRadius.circular(8)),
                              minimumSize: const Size(double.infinity, 50),
                              primary: Color(0xFF767479))),
                  SizedBox(
                    height: hi / 50,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        Container(
          height: 50,
          child: TextFormField(
            obscureText: type == TextInputType.visiblePassword ? true : false,
            keyboardType: type,
            cursorColor: Colors.black,
            controller: controllerText,
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
                  borderSide: BorderSide(color: Color(ColorTextField))),
              hintText: Title,
              hintStyle:
                  TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
            ),
          ),
        ),
      ],
    );
  }

  Widget SystemOrExpert() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.green;
                }),
                value: "YES".tr,
                groupValue: group,
                onChanged: (value) {
                  setState(() {
                    group = value.toString();
                    graduated = '1';
                  });
                }),
            SizedBox(
              width: 15,
            ),
            Text(
              'YES'.tr,
              style: TextStyle(
                  fontFamily: 'Cobe',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.red;
                }),
                value: "NO".tr,
                groupValue: group,
                onChanged: (value) {
                  setState(() {
                    group = value.toString();
                    graduated = '0';
                  });
                }),
            SizedBox(
              width: 15,
            ),
            Text(
              'NO'.tr,
              style: TextStyle(
                  fontFamily: 'Cobe',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
