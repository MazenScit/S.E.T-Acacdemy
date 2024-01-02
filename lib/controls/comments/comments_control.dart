import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:http/http.dart' as http;
import 'package:setacademyapp/screen/my_courses/my_courses_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../../Utils/general_URL.dart';
import '../../model/my_coursee_model.dart';

// ignore: camel_case_types
class comments_control {
  Future add_comments(String id, String comment, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);

    String myUrl = "$serverUrl/courses/${id}/";
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
    }, body: {
      'comment': comment
    });

    print(api_token);
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Done!'.tr,
            message: ' ',
            contentType: ContentType.success,
          ),
        ));
    } else {
      print('else');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Please try again later'.tr,
            message: ' ',
            contentType: ContentType.warning,
          ),
        ));
    }
  }
}
