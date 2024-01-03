import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/Utils/general_URL.dart';
import 'package:setacademyapp/auth/log_in.dart';
import 'package:setacademyapp/screen/my_courses/my_courses_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Utils/Color.dart';
import 'auth/profile.dart';
import 'controls/complaints/complaints.dart';
import 'logale/locale_Cont.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class Drawer5 extends StatefulWidget {
  Drawer5({Key? key}) : super(key: key);

  @override
  State<Drawer5> createState() => _Drawer5State();
}

class _Drawer5State extends State<Drawer5> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  MyLocaleController controller = Get.find();

  TextEditingController ControllerContact = TextEditingController();
  final Color primary = Colors.white;
  complaints _complaints = complaints();
  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height-50;
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 16),
        decoration: BoxDecoration(
            color: primary,
            boxShadow: const [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: active,
                      size: 30,
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return login();
                      }));
                    },
                  ),
                ),
                SizedBox(height: _height / 5),
                _buildRow(Icons.book, "My Courses".tr),
                _buildDivider(),
                _buildRow(Icons.person, "Profile".tr),
                _buildDivider(),
                _buildRow(Icons.language, "Language".tr),
                // _buildRow(Icons.settings, "Settings"),
                _buildDivider(),
                _buildRow(Icons.email, "Complaints".tr),
                _buildDivider(),
                SizedBox(
                  height: _height / 3,
                ),
                apiacceptencevariable.toString()!="0"?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 75,
                      child: _buildDivider(),
                    ),
                    Text("Contact us".tr),
                    Container(
                      width: 75,
                      child: _buildDivider(),
                    ),
                  ],
                ):SizedBox(),
                apiacceptencevariable.toString()!="0"?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                builder: (context, StateSetter setState) {
                              return SingleChildScrollView(
                                // controller: ModalScrollController.of(context),
                                child: bottomSheetPhone(setState),
                              );
                            }),
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.phone)),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                builder: (context, StateSetter setState) {
                              return SingleChildScrollView(
                                // controller: ModalScrollController.of(context),
                                child: bottomSheetWhatsapp(setState),
                              );
                            }),
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.whatsapp)),
                    IconButton(
                        onPressed: () {
                          launcher.launch(
                              "https://www.facebook.com/S.E.T1989?mibextid=ZbWKwL");
                        },
                        icon: FaIcon(FontAwesomeIcons.facebook)),
                    IconButton(
                        onPressed: () {
                          launcher.launch(
                              "https://instagram.com/set___center?igshid=ODM2MWFjZDg=");
                        },
                        icon: FaIcon(FontAwesomeIcons.instagram)),
                    IconButton(
                        onPressed: () {
                          launcher.launch("mailto:set.center15@gmail.com");
                        },
                        icon: Icon(
                          Icons.email,
                          size: 30,
                        ))
                  ],
                ):SizedBox(),
                // _buildRow(Icons.email, "Contact us".tr),
                // _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return InkWell(
      onTap: () {
        if (title == 'My Courses'.tr) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return myCourses();
          }));
        } else if (title == 'Language'.tr) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    actions: [dialogOffers()],
                  ));
        } else if (title == 'Complaints'.tr) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    actions: [contact_us(context)],
                  ));
        } else if (title == 'Profile'.tr) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Profile();
          }));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: active,
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: tStyle,
            ),
            const Spacer(),
            // if (showBadge)
            //   Material(
            //     color: Colors.deepOrange,
            //     elevation: 5.0,
            //     shadowColor: Colors.red,
            //     borderRadius: BorderRadius.circular(5.0),
            //     child: Container(
            //       width: 25,
            //       height: 25,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color: Colors.deepOrange,
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //       child: const Text(
            //         "5",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Container dialogOffers() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            'choose language',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          button('Arabic', 'ar'),
          SizedBox(
            height: 25,
          ),
          button('English', 'en'),
        ],
      ),
    );
  }

  _save(String long) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'long';
    final value = long;
    prefs.setString(key, value);
  }

  Container bottomSheetPhone(setStates) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black38),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Contact us".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                launcher.launch('tel://00963938700160');
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0938700160',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                launcher.launch('tel://00963933503106');
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0933503106',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                launcher.launch('tel://00963957867588');
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0957867588',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container bottomSheetWhatsapp(setStates) {
    print(apiacceptencevariable.toString()!="0");
    return 
    apiacceptencevariable.toString()!="0"?
    Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black38),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Contact us".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                launcher.launch("whatsapp://send?phone=00963938700160");
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0938700160',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                launcher.launch("whatsapp://send?phone=00963933503106");
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0933503106',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                launcher.launch("whatsapp://send?phone=00963957867588");
              },
              child: Card(
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      '0957867588',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    ):Container();
  }

  Container contact_us(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            'Complaints'.tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: 8,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            controller: ControllerContact,
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
              hintText: 'Enter the complaint'.tr,
              hintStyle:
                  TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              print(ControllerContact.text);
              _complaints.add_complaints(
                  ControllerContact.text.toString(), context);
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

  Column button(String title, String long) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              print(long);
              controller.changeLang(long);
              _save(long);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return myCourses();
              }));
            });
            Navigator.of(context).pop();
          },
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  // side: BorderSide(width: 2.0, color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(190, 50),
              primary: Colorbutton),
        )
      ],
    );
  }
}
