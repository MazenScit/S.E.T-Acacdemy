import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EndVersion extends StatelessWidget {
  final String url;
  const EndVersion({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("update youre app"),
              SizedBox(height: 20,),
              Icon(Icons.warning,color: Colors.red,size: 50,),
              SizedBox(height: 20,),
              TextButton(onPressed: () {
                _launchInWebViewWithoutDomStorage(url);
              }, child: Text("download now",style: TextStyle(color: Colors.blue),))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInWebViewWithoutDomStorage(String url) async {
  final uri =
    Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw Exception('Could not launch $url');
    }





   
  }
}