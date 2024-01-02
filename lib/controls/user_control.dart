import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import '../Utils/general_URL.dart';
import '../model/User_model.dart';
import '../screen/my_courses/my_courses_screen.dart';

// ignore: camel_case_types
class User_Control {
  login(context, String username, String password, String device_token) async {
    var myUrl = Uri.parse("$serverUrl/login");
    final response = await http.post(myUrl, body: {
      "phone": username,
      "password": password,
      'device_token': device_token
    });

    print(device_token);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      _save(json.decode(response.body)['api_token'].toString());

      print('Done');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return myCourses();
      }), (route) => false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return myCourses();
      // }));
    } else
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'Account not found'.tr,
        desc: 'Make sure the data is correct'.tr,
        // btnOkOnPress: () {},
      )..show();
  }

  Future register(
      String first_name,
      String middle_name,
      String last_name,
      String phone,
      String password,
      String email,
      String governorate_id,
      String address,
      String specialization_id,
      String university_id,
      String graduated,
      String year,
      String device_token,
      context) async {
    var myUrl = Uri.parse("$serverUrl/register");

    final response = await http.post(myUrl, body: {
      "first_name": first_name,
      "middle_name": middle_name,
      "last_name": last_name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': password,
      'governorate_id': governorate_id,
      'specialization_id': specialization_id,
      'university_id': university_id,
      'address': address,
      'graduated': graduated.toString(),
      'year': year,
      'device_token': device_token,
    });

    print(response.body);
    if (response.statusCode == 200) {
      _save(json.decode(response.body)['api_token'].toString());

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return myCourses();
      }), (route) => false);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: jsonDecode(response.body)['message'].toString(),
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future<user_model?> get_profile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final value = prefs.get(key);

    String myUrl = "$serverUrl/profile";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Authorization': 'Bearer $value',
      'Accept': 'application/json'
    });

    print(response.body);

    if (response.statusCode == 200) {
      try {
        // status = true;
        user_model user = user_model.fromJson(jsonDecode(response.body));
        return user;
      } catch (error) {
        print(error);
      }
    } else if (response.statusCode == 404) {
      // status = false;
    } else {
      print(response.body);
      print(response.statusCode);
      // status = false;
      //  login_status = true;
      throw "Error While getting profile";
    }
  }

  Future<user_model?> update_profile(
      String first_name,
      String middle_name,
      String last_name,
      String email,
      String phone,
      String governorate,
      String address,
      String university,
      String specialization,
      String graduated,
      String year,
      context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final value = prefs.get(key);

    String myUrl = "$serverUrl/profile";
    http.Response response = await http.put(Uri.parse(myUrl), headers: {
      'Authorization': 'Bearer $value',
      'Accept': 'application/json'
    }, body: {
      'first_name': first_name,
      'middle_name': middle_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'governorate': governorate,
      'address': address,
      'university': university,
      'specialization': specialization,
      'graduated': graduated,
      'year': year,
    });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else if (response.statusCode == 404) {
      // status = false;
    } else {
      // status = false;
      //  login_status = true;
      throw "Error While getting profile";
    }
  }

  Future<user_model?> send_code(String phone, context) async {
    String myUrl = "$serverUrl/send-code";
    String phone1 = phone.substring(1);

    http.Response response =
        await http.post(Uri.parse(myUrl), body: {'phone': '963' + phone1});

    print(response.body);

    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'The verification code has been sent successfully'.tr,
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future verify_code(
      String first_name,
      String middle_name,
      String last_name,
      String phone,
      String password,
      String email,
      String governorate_id,
      String address,
      String specialization_id,
      String university_id,
      String graduated,
      String year,
      String device_token,
      String code,
      context) async {
    String myUrl = "$serverUrl/verify-code";
    String phone1 = phone.substring(1);

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'phone': '963' + phone1,
      'code': code,
    });

    print(response.body);

    if (response.statusCode == 200) {
      register(
          first_name,
          middle_name,
          last_name,
          phone,
          password,
          email,
          governorate_id,
          address,
          specialization_id,
          university_id,
          graduated,
          year,
          device_token,
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
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final value = token;
    prefs.setString(key, value);
  }
}
