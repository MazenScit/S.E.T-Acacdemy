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
class get_quizzes {
  bool status = false;

  Future<List<quizzes_model>?> quizzes(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);

    print(api_token);

    String myUrl = "$serverUrl/quizzes?chapter_id=${id}";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      // 'long': 'ar'
    });
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<quizzes_model> orders = body
            .map(
              (dynamic item) => quizzes_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);

        return null;
      }
    } else {
      print(response.body);
      // throw "Error While getting Properties";
    }
  }

  Future<List<question_model>?> question(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');

    print(api_token);

    String myUrl = "$serverUrl/quizzes?chapter_id=${id}";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      'long': long.toString()
    });
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      print('body');
      print(body);
      try {
        List<question_model> orders = body
            .map(
              (dynamic item) => question_model.fromJson(item),
            )
            .toList();
        return orders;
      } catch (error) {
        print(error);

        return null;
      }
    } else {
      print(response.body);
      // throw "Error While getting Properties";
    }
  }
}
