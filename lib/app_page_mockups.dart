import 'dart:math';

import 'package:aartas_design_system/const.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AppPageMockups extends StatefulWidget {
  final ScrollController controller;
  final Function(bool) isLock;
  const AppPageMockups({
    super.key,
    required this.controller,
    required this.isLock,
  });

  @override
  State<AppPageMockups> createState() => _AppPageMockupsState();
}

class _AppPageMockupsState extends State<AppPageMockups> {
  late ScrollController controller;
  late VideoPlayerController videoPlayerController;
  late VisibilityDetectorController visibilityDetectorController;
  bool isLoadingComplete = false;
  bool showText = false;
  bool enableScroll = false;
  List<String> leftList = ["App1.jpg", "App2.jpg", "App3.jpg"];
  List<String> rightList = ["App4.jpg", "App5.jpg", "App6.jpg"];
  GlobalKey mockupKey = GlobalKey();
  double? visiblePercentage = 0;
  Size? mockupSize;
  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.atEdge) {
        enableScroll = false;
        widget.isLock(false);
      } else {
        widget.isLock(true);
      }
    });
    videoPlayerController = VideoPlayerController.asset("aartas_video.mp4")
      ..initialize().then((value) {
        videoPlayerController.setVolume(0);
        videoPlayerController.setLooping(true);
        videoPlayerController.play();
        setState(() {});
      });
    visibilityDetectorController = VisibilityDetectorController.instance;
    visibilityDetectorController.notifyNow();
    getMockupSize();
    super.initState();
  }

  getMockupSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mockupSize = mockupKey.currentContext!.size;
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("App Mockups");
    return VisibilityDetector(
      key: const Key("app-page-visible"),
      onVisibilityChanged: (info) {
        visiblePercentage = info.visibleFraction * 100;
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: mediaQuery(context).size.width > 700
                ? Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      minWidth: 100,
                      maxHeight: 250,
                      maxWidth: mediaQuery(context).size.height / 2,
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      child: Row(
                        children: leftList
                            .asMap()
                            .entries
                            .map(
                              (e) => AppCardImage(
                                image: e.value,
                                visible:
                                    visiblePercentage! * (e.key + 0.9) * 0.2,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : AnimatedContainer(
                    duration: duration,
                    padding: EdgeInsets.only(
                        bottom: min(visiblePercentage! * 0.64, 64)),
                    child: Column(
                      children: leftList
                          .asMap()
                          .entries
                          .map(
                            (e) => AppCardImage(
                              image: e.value,
                              visible: visiblePercentage! * (e.key + 0.9),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
          FittedBox(
            child: Container(
              key: mockupKey,
              constraints: BoxConstraints(
                maxHeight: mediaQuery(context).size.width > 700 ? 600 : 400,
                minHeight: 100,
                // maxWidth: 250,
              ),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              foregroundDecoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "iphone_mockup.png",
                  ),
                ),
              ),
              padding: const EdgeInsets.all(4),
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1179 / 2556,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: themeData(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(
                        40,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: videoPlayerController.value.size.width,
                        height: videoPlayerController.value.size.height,
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: mediaQuery(context).size.width > 700
                ? Container(
                    constraints: BoxConstraints(
                      // minHeight: 100,
                      // minWidth: 100,
                      maxHeight: 250,
                      maxWidth: mediaQuery(context).size.height / 2,
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: rightList
                            .asMap()
                            .entries
                            .map(
                              (e) => AppCardImage(
                                image: e.value,
                                visible:
                                    (1 - (visiblePercentage! * (e.key + 0.9)))
                                        .abs(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : AnimatedContainer(
                    duration: duration,
                    padding: EdgeInsets.only(
                      top: min(visiblePercentage! * 0.64, 64),
                    ),
                    child: Column(
                      children: rightList
                          .asMap()
                          .entries
                          .map(
                            (e) => AppCardImage(
                              image: e.value,
                              visible: visiblePercentage! * (e.key + 0.9),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class AppCardImage extends StatefulWidget {
  final double? visible;
  final String? image;
  const AppCardImage({
    super.key,
    this.image,
    this.visible,
  });

  @override
  State<AppCardImage> createState() => _AppCardImageState();
}

class _AppCardImageState extends State<AppCardImage> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedOpacity(
        duration: duration,
        opacity: min(widget.visible != null ? widget.visible! / 100 : 0.2, 1),
        child: Container(
          // width: mediaQuery(context).size.width > 700 ? 200 : double.infinity,
          // height: mediaQuery(context).size.width > 700 ? 200 : double.infinity,
          margin: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
              // minHeight: 100,
              // minWidth: 100,
              // maxHeight: 200,
              // maxWidth: 200,
              ),
          color: burntUmberColor,
          child: Image(
            image: AssetImage("${widget.image}"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
