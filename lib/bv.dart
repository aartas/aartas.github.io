// import 'package:aartas_design_system/const.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class BV extends StatefulWidget {
//   final String? assetImage;
//   final String? networkImage;
//   final bool? loop;
//   const BV({
//     Key? key,
//     this.assetImage,
//     this.networkImage,
//     this.loop,
//   }) : super(key: key);

//   @override
//   BVState createState() => BVState();
// }

// class BVState extends State<BV> {
//   late VideoPlayerController _videoPlayerController;
//   bool _showVideo = false;
//   @override
//   void initState() {
//     super.initState();
//     if (widget.assetImage != null && widget.assetImage != "") {
//       _videoPlayerController = VideoPlayerController.asset(
//         "${widget.assetImage}",
//       )..initialize().then((value) {
//           setState(() {
//             _showVideo = true;
//           });
//         });
//     }
//     if (widget.networkImage != null && widget.networkImage != "") {
//       _videoPlayerController = VideoPlayerController.network(
//         "${widget.networkImage}",
//       )..initialize().then((value) {
//           setState(() {
//             _showVideo = true;
//           });
//         });
//     }
//     _videoPlayerController.play();
//     _videoPlayerController.setLooping(widget.loop != null && widget.loop!);
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: seaShellColor,
//       child: Stack(
//         children: [
//           SizedBox.expand(
//             child: FittedBox(
//               fit: BoxFit.cover,
//               child: SizedBox(
//                 width: _videoPlayerController.value.size.width,
//                 height: _videoPlayerController.value.size.height,
//                 child: VideoPlayer(_videoPlayerController),
//               ),
//             ),
//           ),
//           // SizedBox.expand(
//           //   child: AnimatedOpacity(
//           //     duration: const Duration(milliseconds: 900),
//           //     opacity: _videoPlayerController.value.isInitialized ? 0 : 1,
//           //     child: const Image(
//           //       image: AssetImage('./assets/landing.png'),
//           //       fit: BoxFit.cover,
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
