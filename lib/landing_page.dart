import 'package:aartas_design_system/const.dart';
import 'package:aartas_website/urls.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  final ScrollController controller;
  const LandingPage({
    super.key,
    required this.controller,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // late VideoPlayerController videoPlayerController;
  bool isLoadingComplete = true;
  bool showText = false;
  @override
  void initState() {
    // videoPlayerController = VideoPlayerController.network(
    //     "https://www.apple.com/105/media/us/supplier-responsibility/2022/de727672-85ac-447c-b50b-046919f843ef/anim/hero/large_2x.mp4")
    //   ..initialize().then((value) {
    //     videoPlayerController.setVolume(0);
    //     videoPlayerController.setLooping(false);
    //     videoPlayerController.play();
    //     setState(() {});
    //   });
    // videoPlayerController.addListener(() {
    //   if (videoPlayerController.value.position ==
    //       videoPlayerController.value.duration) {
    //     Future.delayed(const Duration(seconds: 1), () {
    //       isLoadingComplete = true;
    //       setState(() {});
    //       Future.delayed(const Duration(seconds: 1), () {
    //         showText = true;
    //         setState(() {});
    //       });
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(textTheme(context).headlineSmall!.fontSize);
    debugPrint("Landing Page");
    return Container(
        color: themeData(context).colorScheme.background,
        height: mediaQuery(context).size.height - 100,
        width: mediaQuery(context).size.width,
        constraints: websiteWidth(context),
        child: isLoadingComplete
            ? Container(
                height: mediaQuery(context).size.height,
                width: mediaQuery(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Aartas is bringing you\n",
                        style: mediaQuery(context).size.width > 700
                            ? textTheme(context).displayMedium?.copyWith(
                                  fontFamily: "TiemposHeadline",
                                  fontWeight: FontWeight.w500,
                                )
                            : textTheme(context).displaySmall?.copyWith(
                                  fontFamily: "TiemposHeadline",
                                  fontWeight: FontWeight.w500,
                                ),
                        children: [
                          TextSpan(
                            text: "Closer to Care.",
                            style: TextStyle(color: burntUmberColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const AnimatedDiscription(),
                  ],
                ),
              )
            : Image(
                image: AssetImage("Group.jpg"),
                fit: BoxFit.cover,
              )
        //  SizedBox(
        //     height: mediaQuery(context).size.height,
        //     width: mediaQuery(context).size.width,
        //     child: FittedBox(
        //       fit: BoxFit.cover,
        //       child: SizedBox(
        //         // width: videoPlayerController.value.size.width,
        //         // height: videoPlayerController.value.size.height,
        //         // child: VideoPlayer(videoPlayerController),
        //       ),
        //     ),
        //   ),
        );
  }
}

class AnimatedDiscription extends StatefulWidget {
  const AnimatedDiscription({
    super.key,
  });

  @override
  State<AnimatedDiscription> createState() => _AnimatedDiscriptionState();
}

class _AnimatedDiscriptionState extends State<AnimatedDiscription>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _opacity = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    _opacityAnimation();
  }

  void _opacityAnimation() {
    _opacity = false;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () {
      _opacity = true;
      _controller.forward();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Animated Discription");
    return SizeTransition(
      sizeFactor: _animation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(32, 16, 16, 0),
        width: mediaQuery(context).size.width,
        alignment: Alignment.center,
        child: SizedBox(
          width: mediaQuery(context).size.width > 1000
              ? 700
              : mediaQuery(context).size.width > 700
                  ? 400
                  : mediaQuery(context).size.width - 64,
          child: Text(
            "Getting the healthcare you deserve no longer requires a tense and tedious process. Consult with the best doctors who care for you, and connect you to the right treatments for your condition.",
            style: mediaQuery(context).size.width > 1000
                ? textTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: charcoalColor.withOpacity(_opacity ? 1 : 0))
                : textTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: charcoalColor.withOpacity(_opacity ? 1 : 0)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
