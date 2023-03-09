import 'package:aartas_design_system/const.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  final ScrollController? mainController;
  final bool? lockMainScroll;
  final Function(bool)? onScroll;
  final String? assetImage;
  final String? networkImage;
  final bool? loop;
  const BackgroundVideo({
    Key? key,
    this.mainController,
    this.lockMainScroll,
    this.onScroll,
    this.assetImage,
    this.networkImage,
    this.loop,
  }) : super(key: key);

  @override
  BackgroundVideoState createState() => BackgroundVideoState();
}

class BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();

    if (widget.assetImage != null && widget.assetImage != "") {
      _videoPlayerController = VideoPlayerController.network(
        "${widget.assetImage}",
      )..initialize().then(
          (_) {
            _videoPlayerController.setVolume(0);
            _videoPlayerController.play();
            _videoPlayerController
                .setLooping(widget.loop != null && widget.loop!);
            setState(() {});
          },
        );
    }
    if (widget.networkImage != null && widget.networkImage != "") {
      _videoPlayerController = VideoPlayerController.network(
        "${widget.networkImage}",
      )..initialize().then(
          (_) {
            _videoPlayerController.setVolume(0);
            _videoPlayerController.play();
            _videoPlayerController
                .setLooping(widget.loop != null && widget.loop!);
            setState(() {});
          },
        );
    }
    // if (widget.mainController != null) {
    //   widget.mainController!.addListener(() {
    //     print(
    //         "MainScroll: ${widget.mainController!.position.pixels} - ${mediaQuery(context).size.height}  --  ${widget.mainController!.position.pixels >= mediaQuery(context).size.height} - ${widget.lockMainScroll}");
    //     if (widget.mainController!.position.pixels >=
    //         mediaQuery(context).size.height) {
    //       print(widget.mainController!.position.pixels);
    //       widget.onScroll!(true);
    //       setState(() {});
    //     } else {
    //       widget.onScroll!(false);
    //       setState(() {});
    //     }
    //   });
    // }
    // childControllers();
  }

  // void childControllers() {
  //   if (childScrollController != null) {
  //     childScrollController!.addListener(() {
  //       print(
  //           "ChildScroll: ${childScrollController!.position.pixels} - ${childScrollController!.position.atEdge} - ${widget.lockMainScroll}");
  //       if (childScrollController!.position.atEdge) {
  //         widget.onScroll!(false);
  //         setState(() {});
  //       }
  //     });
  //   }
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Video Player");
    return SizedBox(
      height: _videoPlayerController.value.size.height,
      width: _videoPlayerController.value.size.width,
      child: VideoPlayer(_videoPlayerController),
    );
  }
}
