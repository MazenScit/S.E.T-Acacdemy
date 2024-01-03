import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/Utils/Color.dart';
import 'package:setacademyapp/Utils/appVersion.dart';
import 'package:setacademyapp/Utils/general_URL.dart';
import 'package:setacademyapp/auth/log_in.dart';
import 'package:setacademyapp/controls/apiacceptence.dart';
import 'package:setacademyapp/controls/appversion.dart';
import 'package:setacademyapp/screen/EndVersion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../logale/locale_Cont.dart';
import '../model/WalkThroughModel.dart';
import 'my_courses/my_courses_screen.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}
bool isloading=false;
ApiAcceptence _apiAcceptence=ApiAcceptence();
class WalkThroughScreenState extends State<WalkThroughScreen> {
  
  PageController pageController = PageController();
  MyLocaleController controller = Get.find();
  AppVersion _appVersion=AppVersion();
  int currentPage = 0;
  check() async {
    _appVersion.getAppVersion().then((value) async {
      if(value?.version!=app_veriosn){
        setState(() {
          isloading=false;
        });
         Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return EndVersion( url:value?.url,);
      }), (route) => false);
         
      }else{
        setState(() {
          isloading=false;
        });
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final token_User = prefs.get(key);

    if (token_User != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return myCourses();
      }), (route) => false);
      print(token_User);
    } else {
      Navigator.of(context).pushReplacementNamed('login');
    }
      }
    });
    
  }

  _save(String long) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'long';
    final value = long;

    prefs.setString(key, value);
    print('done...22' + long);
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

  @override
  void initState() {
    _apiAcceptence.getacceptance().then((value) {
       apiacceptencevariable=value.toString();
       print("apiacceptencevariable"+apiacceptencevariable.toString());
    });
    super.initState();
    get_long();
    init();
  }

  void init() async {
    //
  }

  List<WalkThroughModel> walkThroughClass = [
    WalkThroughModel(
      name: ' ',
      text: " ",
      img: 'assets/images/welcome/set_1.png',
    ),
    WalkThroughModel(
      name: ' ',
      text: " ",
      img: 'assets/images/welcome/set_2.png',
    ),
    WalkThroughModel(
      name: ' ',
      text: " ",
      img: 'assets/images/welcome/set_3.png',
    )
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 233, 215, 241),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: walkThroughClass.length,
              controller: pageController,
              itemBuilder: (context, i) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      walkThroughClass[i].img.toString(),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Positioned(
                      bottom: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(walkThroughClass[i].name!,
                              textAlign: TextAlign.center),
                          SizedBox(height: 16),
                          Text(walkThroughClass[i].text.toString(),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                );
              },
              onPageChanged: (int i) {
                currentPage = i;
                setState(() {});
              },
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      if (currentPage.toInt() >= 2) {
                        check();
                        // Navigator.pushAndRemoveUntil(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return login();
                        // }), (route) => false);
                      } else {
                        pageController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.linearToEaseOut);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colorbutton),
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isloading=true;
                  });
                  check();

                  // Navigator.pushAndRemoveUntil(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return login();
                  // }), (route) => false);
                },
                child: 
                !isloading?
                Text(
                  'Skip',
                  style: TextStyle(
                      color: Colorbutton, fontWeight: FontWeight.bold),
                ):CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}


