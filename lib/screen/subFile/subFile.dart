// import 'dart:isolate';

// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:sett/Utils/imageURL.dart';
// import 'package:sett/model/chapters_model.dart';

// import '../../Utils/Color.dart';
// import '../../controls/Control_Download.dart';
// import '../../controls/get_control.dart';
// import '../../drawer/drawer.dart';
// import '../../model/files_model.dart';

// class subFile extends StatefulWidget {
//   // String id;
//   // String name;
//   subFile({Key? key}) : super(key: key);

//   @override
//   State<subFile> createState() => _subFileState();
// }

// class _subFileState extends State<subFile> {
//   Download _download = Download();
//   Dio dio = Dio();
//   double progress = 0.0;
//   get_Control _get_control = get_Control();
//   List<courses_model> _files = [];

//   bool isloading = true;
//   String isloadingBook = '0';

//   getfiles() {
//     print(widget.id.toString());
//     _get_control
//         .get_chapters(widget.id.toString())
//         .then((value) => setState(() {
//               _files = value!;
//               isloading = false;
//             }));
//   }

//   ReceivePort _port = ReceivePort();
//   List<files_model> _books = [];

//   getbooks(String id) {
//     print('object');
//     _get_control.get_books(id).then((value) => setState(() {
//           _books = value!;
//           // _download.get_Download(_books[0].file_url.toString());

//           _download
//               .get(
//                   _books[0].file_url.toString(), _books[0].file_name.toString())
//               .whenComplete(() {
//             if (_download.state == true) {
//               setState(() {
//                 isloadingBook = '2';
//               });
//             }
//           });
//         }));
//   }

//   @override
//   void initState() {
//     getfiles();

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double wi = MediaQuery.of(context).size.width;
//     double hi = MediaQuery.of(context).size.height;
//     return Scaffold(
//       drawer: CoustomDrawer(),
//       body: ColorfulSafeArea(
//         color: Colors.black,
//         child: Container(
//           color: Colors.red,
//           child: SafeArea(
//               child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.centerRight,
//                 end: Alignment.centerLeft,
//                 colors: [
//                   Color(Colorbutton),
//                   Color(0xFF9573ec),
//                 ],
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: hi / 6,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset(logo),
//                       IconButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           icon: Icon(
//                             Icons.arrow_forward,
//                             color: Colors.white,
//                             size: 30,
//                           ))
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 6,
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     width: wi,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.only(topLeft: Radius.circular(50))),
//                     child: isloading
//                         ? Center(
//                             child: CircularProgressIndicator(
//                             color: Color(Colorbutton),
//                           ))
//                         : Column(
//                             children: [
//                               Text('widget.name',
//                                   style: TextStyle(
//                                       fontFamily: 'Cobe',
//                                       fontWeight: FontWeight.bold,
//                                       overflow: TextOverflow.ellipsis,
//                                       fontSize: 18)),
//                               Container(
//                                 height: hi / 1.5,
//                                 child: ListView.builder(
//                                   itemCount: _files.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return items(_files[index]);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//         ),
//       ),
//     );
//   }

//   Widget items(courses_model courses) {
//     return Card(
//       elevation: 8,
//       child: ListTile(
//           onTap: () {
//             setState(() {
//               isloadingBook = '1';
//             });

//             getbooks(courses.id.toString());
//             super.initState();
//           },
//           title: Text(
//             courses.title.toString(),
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(fontFamily: 'Cobe', fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(
//             'اضغط لتقوم بتحميل الكتاب',
//             style: TextStyle(
//               fontFamily: 'Cobe',
//               fontWeight: FontWeight.bold,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           leading: Image.asset(
//             logo,
//             height: 75,
//           ),
//           trailing: isloadingBook == '0'
//               ? SizedBox()
//               : isloadingBook == '1'
//                   ? CircularProgressIndicator(
//                       color: Color(Colorbutton),
//                     )
//                   : Icon(
//                       Icons.done,
//                       color: Colors.green,
//                     )),
//     );
//   }
// }
