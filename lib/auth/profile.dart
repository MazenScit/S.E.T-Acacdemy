import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:setacademyapp/controls/get_control.dart';
import 'package:setacademyapp/controls/image_profile/image_profile.dart';
import 'package:setacademyapp/model/User_model.dart';
import '../Utils/Color.dart';
import '../Utils/general_URL.dart';
import '../controls/user_control.dart';
import '../model/governorates.dart';
import '../model/specializations.dart';
import '../model/universities.dart';
import 'val.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  XFile? pickedFile;
  File? imageFile;
  String graduated = '1';
  List<Mgovernorates>? Lgovernorates = [];
  var governorate;

  List<Mspecializations>? Lspecializations = [];
  var specialization;

  List<Muniversities>? Luniversities = [];
  var universitie;

  List<String> Lyear = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  bool isLoading = true;

  get_Control _get_control = get_Control();
  profile_image _pro = profile_image();
  val _vre = val();
  User_Control _user_control = User_Control();

  user_model? user;

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

  String? image;

  get_profile() {
    _user_control.get_profile().then((value) {
      setState(() {
        user = value;
        isLoading = false;
      });
      fnameController.text = user!.first_name.toString();
      mnameController.text = user!.middle_name.toString();
      lnameController.text = user!.first_name.toString();
      phoneController.text = user!.phone.toString();
      emailController.text = user!.email.toString();
      addressController.text = user!.address.toString();
      image = user!.image.toString();
    });
  }

  @override
  void initState() {
    getgovernorate();
    getuniversitie();
    getspecialization();
    get_profile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colorbutton,
          centerTitle: true,
          title: Text('Profile'),
        ),
        body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colorbutton,
                  ),
                )
              : Container(
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
                        SizedBox(
                          height: hi / 30,
                        ),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                image.toString(),
                                height: 150,
                                width: 150,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      _getFromcamera();
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colorbutton,
                                    )))
                          ],
                        ),
                        SizedBox(
                          height: hi / 50,
                        ),
                        form(fnameController, 'First Name'.tr,
                            TextInputType.name, ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(mnameController, 'Middle Name'.tr,
                            TextInputType.name, ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(lnameController, 'Last Name'.tr,
                            TextInputType.name, ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(phoneController, 'phone'.tr, TextInputType.phone,
                            ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(passwordController, 'Password'.tr,
                            TextInputType.visiblePassword, ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(emailController, 'Email'.tr,
                            TextInputType.emailAddress, ''),
                        SizedBox(
                          height: hi / 70,
                        ),
                        apiacceptencevariable.toString()!="0"?
                        Column(
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
                            ),
                          ],
                        ):SizedBox(),
                        SizedBox(
                          height: hi / 70,
                        ),
                        form(addressController, 'Address'.tr,
                            TextInputType.name, ''),
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
                                  border: Border.all(
                                      width: 1, color: Color(0xff34196b))),
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
                        apiacceptencevariable.toString()!="0"?
                        Column(
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
                            ),
                          ],
                        ):SizedBox(),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xff34196b))),
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
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Color(0xff34196b)),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: hi / 80,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _user_control.update_profile(
                                  fnameController.text.toString(),
                                  mnameController.text.toString(),
                                  lnameController.text.toString(),
                                  emailController.text.toString(),
                                  phoneController.text.toString(),
                                  governorate.toString(),
                                  addressController.text.toString(),
                                  universitie.toString(),
                                  specialization.toString(),
                                  graduated.toString(),
                                  year.toString(),
                                  context);
                            },
                            child: Text(
                              'Save'.tr,
                              style: TextStyle(
                                  fontFamily: 'Cobe',
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                minimumSize: const Size(150, 50),
                                primary: Colors.green)),
                        SizedBox(
                          height: hi / 50,
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  _getFromcamera() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      _pro.prof_image(imageFile!, context);
    }
  }

  Column form(controllerText, String Title, TextInputType type, String val) {
    return Column(
      children: [
        Container(
          height: 50,
          child: TextFormField(
            // initialValue: val,

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
                    borderSide: BorderSide(color: ColorTextField!)),
                hintText: Title,
                hintStyle:
                    TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
                label: Text(
                  Title,
                  style: TextStyle(color: Colorbutton),
                )),
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
