

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UaeController {
//     Future<String?> getpassword() async {
//     String myUrl = "https://set-institute.net/api/password-ae";
//     print(myUrl);
//     http.Response response = await http.get(Uri.parse(myUrl) );
//     if (response.statusCode == 200) {
//       print(response.body);
//       try {
        
//         return jsonDecode(response.body)['password'];
//       } catch (error) {
//         print(error);

//         return null;
//       }
//     } else {
//       return null;
//       // throw "Error While getting Properties";
//     }
//   }

//   Future<String?> geturl(String phonenumber,String code) async {
//     String myUrl = "https://set-institute.net/api/password-ae?to="+phonenumber+"&token="+code;
//     print(myUrl);
//     http.Response response = await http.get(Uri.parse(myUrl) );
//     if (response.statusCode == 200) {
//       print(response.body);
//       try {
//         String uaeUrl=jsonDecode(response.body)['base_url'].toString();
//         String filtered="";
//         for (var i = 0; i < uaeUrl.length; i++) {
//           if (!(uaeUrl[i]=="1"||uaeUrl[i]=="2"||uaeUrl[i]=="3"||uaeUrl[i]=="4"||uaeUrl[i]=="5"||
//           uaeUrl[i]=="6"||uaeUrl[i]=="7"||uaeUrl[i]=="8"||uaeUrl[i]=="9")) {
//             // print(uaeUrl[i]);
//              filtered=filtered+uaeUrl[i];
//           }
//         }
//         // print("here filtered "+filtered+jsonDecode(response.body)['url']);
//         return filtered+jsonDecode(response.body)['url'];
//       } catch (error) {
//         print(error);

//         return null;
//       }
//     } else {
//       return null;
//       // throw "Error While getting Properties";
//     }
//   }


// }