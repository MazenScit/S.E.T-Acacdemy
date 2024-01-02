// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:convert';

// import '../Utils/general_URL.dart';
// import '../models/Mfavorite.dart';

// // ignore: camel_case_types
// class favorite_Control {
//   bool status = false;

//   Future add_favorite(String job_id, context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'token';
//     final customer_id = prefs.get(key) ?? 0;
//     String myUrl = "$serverUrl/add_favorite";
//     http.Response response = await http.post(Uri.parse(myUrl),
//         body: {'job_id': job_id, 'customer_id': customer_id});

//     if (json.decode(response.body)['status'].toString() == "1") {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'تمت الاضافة الى المفضلة',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.green,
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'الفرصة موجودة في المفضلة من قبل',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   Future delete_favorite(String id, context) async {
//     String myUrl = "$serverUrl/delete_favorite";
//     http.Response response =
//         await http.post(Uri.parse(myUrl), body: {'id': id});

//     if (json.decode(response.body)['status'].toString() == "1") {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'تمت الازالة من المفضلة',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.green,
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           'حدث خطأ ما',
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   Future<List<Mfavoite>?> get_my_favorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'token';
//     final customer_id = prefs.get(key) ?? 0;
//     String myUrl = "$serverUrl/get_my_favorites";
//     http.Response response =
//         await http.post(Uri.parse(myUrl), body: {'customer_id': customer_id});
//     print(customer_id);

//     if (json.decode(response.body)['status'] == "1") {
//       List body = jsonDecode(response.body)['data'];
//       try {
//         List<Mfavoite> orders = body
//             .map(
//               (dynamic item) => Mfavoite.fromJson(item),
//             )
//             .toList();
//         return orders;
//       } catch (error) {
//         print(error);

//         return null;
//       }
//     } else {
//       print(response.body);
//       // throw "Error While getting Properties";
//     }
//   }
// }
