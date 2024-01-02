// import 'dart:math';

// import 'package:get/get.dart';
// import 'package:setacademyapp/screen/sendmessagesystem/controller/uaecontroller.dart';
// import 'package:url_launcher/url_launcher.dart';
// UaeController uaeController=UaeController();
// late String uaelurl;
// geturl(phonenumber,code) async {
//   await uaeController.geturl(phonenumber, code.toString()).then((value) {
//      uaelurl=value!;
//   });
// }
// sendmessage(String phonenumber) async {

//   Random rnd;
//   int min = 100000;
//   int max = 999999;
//   rnd = new Random();
//   String completephonenumber = "963" + phonenumber.substring(1, 10);
//   print(completephonenumber);
//   int code = min + rnd.nextInt(max - min);
//   geturl(phonenumber,code.toString()).whenComplete((){
//     print(uaelurl);
//       _launchURL(uaelurl);
    
//   });
//   print("code");
//   return code.toString();
//   // String encrypted=encription(code.toString());

// }

// _launchURL(String _url) async {
//   final Uri url = Uri.parse(_url);

//   if (!await launchUrl(url)) {
//     throw Exception('Could not launch $_url');
//   }
// }

// // encription(String plainText){
// //   final key = Key.fromSecureRandom(32);
// //   final iv = IV.fromSecureRandom(16);
// //   final encrypter = Encrypter(AES(key));
// //   final encrypted = encrypter.encrypt(plainText, iv: iv);
// //   final decrypted = encrypter.decrypt(encrypted, iv: iv);
// //   print(decrypted);
// //   print(encrypted.base16);
// //   print(encrypted.base64);
// //   return encrypted.base16;
// // }