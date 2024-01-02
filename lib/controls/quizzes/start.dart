import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:setacademyapp/model/categories_model.dart';
import 'package:setacademyapp/model/governorates.dart';
import 'package:setacademyapp/model/question_model.dart';
import 'package:setacademyapp/model/specializations.dart';
import 'package:setacademyapp/model/universities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../../Utils/general_URL.dart';
import '../../model/lessons_model.dart';
import '../../model/my_coursee_model.dart';
import '../../model/quizzes_model.dart';

// ignore: camel_case_types
class start_quizzes {
  bool status = false;

  Future start(String id, context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);

    print(api_token);

    String myUrl = "$serverUrl/quizzes/${id}/start";
    http.Response response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      // 'long': 'ar'
    });
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      status = true;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: jsonDecode(response.body)['message'].toString(),
        // btnOkOnPress: () {},
      ).show();
      // throw "Error While getting Properties";
    }
  }
}
