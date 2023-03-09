import 'package:aartas_design_system/const.dart';
import 'package:aartas_website/background_video.dart';
import 'package:aartas_website/urls.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoScrollPage extends StatefulWidget {
  final ScrollController controller;
  final Function(bool) isLock;
  const VideoScrollPage({
    super.key,
    required this.controller,
    required this.isLock,
  });

  @override
  State<VideoScrollPage> createState() => _VideoScrollPageState();
}

class _VideoScrollPageState extends State<VideoScrollPage> {
  late VisibilityDetectorController visibilityDetectorController;
  late ScrollController controller;
  double viewportPercentage = 0;
  bool enableScroll = false;

  customScrollControllerLogic() {}

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.position.atEdge) {
        enableScroll = false;
        widget.isLock(false);
      }

      widget.controller.addListener(() {
        // print("mainController: ${widget.controller.position.pixels}");
      });
    });
    visibilityDetectorController = VisibilityDetectorController.instance;
    visibilityDetectorController.notifyNow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("ViewPort $viewportPercentage");
    // return SliverToBoxAdapter(
    //   child: VisibilityDetector(
    //     key: const Key('video-scroll'),
    //     onVisibilityChanged: (info) {
    //       viewportPercentage = info.visibleFraction * 100;
    //       setState(() {});
    //     },
    //     child: SizedBox(
    //       height: mediaQuery(context).size.height * 1.5,
    //       child: Stack(
    //         children: [
    //           AnimatedPositioned(
    //             duration: duration,
    //             child: Container(
    //               color: burntUmberColor,
    //               height: mediaQuery(context).size.height,
    //               width: mediaQuery(context).size.width,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return SliverAppBar(
      expandedHeight: mediaQuery(context).size.height * 1.5,
      flexibleSpace: FlexibleSpaceBar(
        // collapseMode: CollapseMode.pin,
        title: Container(
          clipBehavior: Clip.hardEdge,
          width: mediaQuery(context).size.width,
          height: mediaQuery(context).size.height * 1.5,
          // color: copperRedColor,
          decoration: const BoxDecoration(),

          child: Stack(
            children: [
              SizedBox(
                width: mediaQuery(context).size.width,
                height: mediaQuery(context).size.height * 1.5,
                child: const FittedBox(
                  fit: BoxFit.cover,
                  child: BackgroundVideo(
                    assetImage: "assets/3.mp4",
                    loop: true,
                  ),
                ),
              ),
              Container(
                width: mediaQuery(context).size.width,
                height: mediaQuery(context).size.height * 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      charcoalColor.withOpacity(0.6),
                      charcoalColor.withOpacity(0.7),
                      charcoalColor.withOpacity(0.8),
                      charcoalColor.withOpacity(0.7),
                      charcoalColor.withOpacity(0.6),
                    ],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  mediaQuery(context).size.width < 500 ? 32 : 96,
                  0,
                  0,
                  mediaQuery(context).size.width < 500 ? 32 : 96,
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    FittedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "“Aartas ensures care like\nfamily, comfort like home.\nExactly how it should be.”",
                            style: mediaQuery(context).size.width < 500
                                ? textTheme(context).headlineSmall?.apply(
                                      color: seaShellColor,
                                      fontWeightDelta: 2,
                                    )
                                : textTheme(context).displaySmall?.apply(
                                      color: seaShellColor,
                                      fontWeightDelta: 2,
                                    ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Dr. Disha Khemani",
                            style: textTheme(context).titleMedium?.apply(
                                  color: seaShellColor,
                                  fontWeightDelta: 1,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ],
          ),
        ),
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1,
      ),
    );
    return Container(
      alignment: Alignment.center,
      width: mediaQuery(context).size.width,
      height: mediaQuery(context).size.height * 1.5,
      child: Stack(
        children: [
          VisibilityDetector(
            key: const Key("video-key"),
            onVisibilityChanged: (info) {
              var visiblePercentage = info.visibleFraction * 100;
              if (visiblePercentage >= 90) {
                // widget.controller
                //     .animateToPage(5, duration: duration, curve: curve);
                widget.isLock(true);
                enableScroll = true;
                setState(() {});
              } else {
                enableScroll = false;
                setState(() {});
              }
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: mediaQuery(context).size.width,
              height: mediaQuery(context).size.height,
              // color: copperRedColor,
              decoration: const BoxDecoration(),
              child: const FittedBox(
                fit: BoxFit.cover,
                child: BackgroundVideo(
                  assetImage: "assets/3.mp4",
                  loop: false,
                ),
              ),
            ),
          ),
          ListView(
            controller: controller,
            physics: enableScroll ? null : const NeverScrollableScrollPhysics(),
            children: [],
          )
        ],
      ),
    );
  }
}
