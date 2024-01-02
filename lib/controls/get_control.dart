import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:setacademyapp/model/categories_model.dart';
import 'package:setacademyapp/model/governorates.dart';
import 'package:setacademyapp/model/specializations.dart';
import 'package:setacademyapp/model/universities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../Utils/general_URL.dart';
import '../model/chapters_model.dart';
import '../model/comment_model.dart';
import '../model/files_model.dart';
import '../model/my_coursee_model.dart';
import '../model/review_model.dart';
import '../model/subcategories.dart';
import '../model/techersmodel.dart';

// ignore: camel_case_types
class get_Control {
  bool status = false;

  Future<List<Muniversities>?> get_universities() async {
    String myUrl = "$serverUrl/universities";

    http.Response response = await http.get(Uri.parse(myUrl));
    if (response.statusCode == 200) {
      print(myUrl);
      print(response.statusCode);
      print(response.body);
      List body = jsonDecode(response.body);
      try {
        List<Muniversities> orders = body
            .map(
              (dynamic item) => Muniversities.fromJson(item),
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

  Future<List<subcategories_model>?> get_subcategories(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    String myUrl = "$serverUrl/subcategories?category_id=${id}";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    print(response.body);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<subcategories_model> orders = body
            .map(
              (dynamic item) => subcategories_model.fromJson(item),
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

  Future<List<techers_model>?> get_techers(String id) async {
    String myUrl = "$serverUrl/courses/${id}/teachers";
    http.Response response = await http.get(Uri.parse(myUrl));
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      List body = jsonDecode(response.body);
      try {
        List<techers_model> orders = body
            .map(
              (dynamic item) => techers_model.fromJson(item),
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

  Future<List<courses_model>?> get_chapter(String id) async {
    print(id);
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    String myUrl = "$serverUrl/chapters?course_id=${id}";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    if (response.statusCode == 200) {
      print(response.body);

      List body = jsonDecode(response.body);
      try {
        List<courses_model> orders = body
            .map(
              (dynamic item) => courses_model.fromJson(item),
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

  Future<List<comment_model>?> get_comments(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');
    String myUrl = "$serverUrl/courses/${id}/comments";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Authorization': 'Bearer ${api_token.toString()}',
      'lang': long.toString()
    });
    print(response.body);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<comment_model> orders = body
            .map(
              (dynamic item) => comment_model.fromJson(item),
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

  Future<List<review_model>?> get_reviews(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');
    String myUrl = "$serverUrl/courses/${id}/reviews";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Authorization': 'Bearer ${api_token.toString()}',
      'lang': long.toString()
    });
    print(response.body);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<review_model> orders = body
            .map(
              (dynamic item) => review_model.fromJson(item),
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

  Future<List<my_coursee_model>?> get_courses(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    print(id);
    String myUrl = "$serverUrl/courses?subcategory_id=${id}";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});

    print(response.body);
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

  Future<List<files_model>?> get_files(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final api_token = prefs.get(key);
    final long = prefs.get('long');
    print(id);
    String myUrl = "$serverUrl/files?chapter_id=${id}";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${api_token.toString()}',
      'lang': long.toString()
    });
    if (response.statusCode == 200) {
      print(response.body);

      List body = jsonDecode(response.body);
      try {
        List<files_model> orders = body
            .map(
              (dynamic item) => files_model.fromJson(item),
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

  Future<List<courses_model>?> get_chapters(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    print(id);
    String myUrl = "$serverUrl/chapters?course_id=${id}";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    if (response.statusCode == 200) {
      print(response.body);

      List body = jsonDecode(response.body);
      try {
        List<courses_model> orders = body
            .map(
              (dynamic item) => courses_model.fromJson(item),
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

  Future<List<files_model>?> get_books(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    print(id);
    String myUrl = "$serverUrl/files?chapter_id=${id}";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    if (response.statusCode == 200) {
      print(response.body);

      List body = jsonDecode(response.body);
      try {
        List<files_model> orders = body
            .map(
              (dynamic item) => files_model.fromJson(item),
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

  Future<List<Mspecializations>?> get_specializations() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    print('object');
    String myUrl = "$serverUrl/specializations";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});

    print(response.statusCode);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<Mspecializations> orders = body
            .map(
              (dynamic item) => Mspecializations.fromJson(item),
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

  Future<List<Mgovernorates>?> get_governorates() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    String myUrl = "$serverUrl/governorates";
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    print(response.statusCode);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<Mgovernorates> orders = body
            .map(
              (dynamic item) => Mgovernorates.fromJson(item),
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

  Future<List<categories_model>?> get_categories() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'api_token';
    final long = prefs.get('long');
    String myUrl = "$serverUrl/categories";
    print(long);
    http.Response response =
        await http.get(Uri.parse(myUrl), headers: {'lang': long.toString()});
    print(response.body);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      try {
        List<categories_model> categories = body
            .map(
              (dynamic item) => categories_model.fromJson(item),
            )
            .toList();
        return categories;
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
