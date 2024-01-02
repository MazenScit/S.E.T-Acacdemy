
  import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DriveVideo extends StatefulWidget {
  final String video_Drive_URl;
  const DriveVideo({Key? key, required this.video_Drive_URl}) : super(key: key);

  @override
  State<DriveVideo> createState() => _TestState();
}

class _TestState extends State<DriveVideo> {
  @override
  void initState() {
     _launchUrl;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
     home:Scaffold(
      body: Center(
            child: ElevatedButton(
              onPressed: _launchUrl,
              child: Text('ٍStart video'),
            ),
          ),
     ),
    );
  }


Future<void> _launchUrl() async {
  final Uri _url = Uri.parse(widget.video_Drive_URl);
  if (!await launchUrl(
    _url,
    mode: LaunchMode.inAppWebView
    )) {
    throw Exception('Could not launch $_url');
  }
}
}