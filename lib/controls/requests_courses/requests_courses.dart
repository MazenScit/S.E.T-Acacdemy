import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as ge;
import 'package:http/http.dart' as http;
import 'package:setacademyapp/auth/val.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../../Utils/general_URL.dart';

// ignore: camel_case_types
class requests_courses {
  bool status = false;
  String? result;
  Future Send_image(File image, String id, String code, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final user_id = prefs.get(key);

    String fileName = image.path.split("/").last;
    var formData = FormData.fromMap({
      'attachment':
          await MultipartFile.fromFile(image.path, filename: fileName),
      'code': ''
    });
    print(id);
    print('$serverUrl/courses/$id/request');
    print(fileName);
    print(image.path);
    print(user_id);
    var dio = Dio();

    var response = await dio.post(
      '$serverUrl/courses/$id/request',
      data: formData,
      options: Options(
        headers: {
          "authorization": "Bearer $user_id",
          "Accept": "application/json"
        },
      ),
    );
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Complaint sent successfully'.tr,
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future send_code(String id, String code, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');

    print(api_token);
    print(long);

    String myUrl = '$serverUrl/courses/$id/request';
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      'lang': long.toString()
    }, body: {
      'code': code,
    });
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Subscription completed successfully'.tr,
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: jsonDecode(response.body)['message'].toString(),
        // btnOkOnPress: () {},
      ).show();
      // throw "Error While getting Properties";
    }
  }
}
