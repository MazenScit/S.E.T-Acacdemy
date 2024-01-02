import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:setacademyapp/model/categories_model.dart';
import 'package:setacademyapp/model/governorates.dart';
import 'package:setacademyapp/model/specializations.dart';
import 'package:setacademyapp/model/universities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../../Utils/general_URL.dart';
import '../../model/my_coursee_model.dart';

// ignore: camel_case_types
class get_my_courses {
  bool status = false;

  Future<List<my_coursee_model>?> my_courses() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');

    print(api_token);
    print(long);

    String myUrl = "$serverUrl/my_courses";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      'lang': long.toString()
    });
    print(myUrl);
    print(response.statusCode);
    print(response.body);
    print('long');
    print(long);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<my_coursee_model> orders = body
            .map(
              (dynamic item) => my_coursee_model.fromJson(item),
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
