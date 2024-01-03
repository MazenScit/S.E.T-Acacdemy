import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:setacademyapp/Utils/Color.dart';
import 'package:setacademyapp/model/lessons_model.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Video extends StatefulWidget {
  new_lessons_model lessons;
  Video({required this.lessons});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  secure() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  TargetPlatform? _platform;
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.network(widget.lessons.video_url.toString());
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    VideoPlayerController videoPlayerController = VideoPlayerController.network(
      widget.lessons.video_url.toString(),
    );

    ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    return Scaffold(
      body: Container(
        child: isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(top: 5),
                    //   child: Row(
                    //     children: [
                    //       IconButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           icon: Icon(Icons.arrow_back_ios))
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              dispose();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 240,
                      child: Center(
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colorbutton,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Text(
                                widget.lessons.title.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Cobe',
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colorbutton,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Text(
                                widget.lessons.duration.toString() + 'm',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Cobe',
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'description'.tr,
                                style:
                                    TextStyle(fontSize: 25, fontFamily: 'Cobe'),
                              ),
                            ],
                          ),
                          Text(
                            widget.lessons.description.toString(),
                            style: TextStyle(fontSize: 25, fontFamily: 'Cobe'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colorbutton,
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController1!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
}
