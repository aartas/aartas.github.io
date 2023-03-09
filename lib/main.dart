// ignore_for_file: prefer_const_constructors

import 'package:aartas_design_system/aartas_design_system.dart';
import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/components/glassmorphism.dart';
import 'package:aartas_design_system/const.dart';
import 'package:aartas_design_system/themes_provider.dart';
import 'package:aartas_website/app_page.dart';
import 'package:aartas_website/app_page_mockups.dart';
import 'package:aartas_website/articles_page.dart';
import 'package:aartas_website/background_video.dart';
import 'package:aartas_website/designed_for_you_page.dart';
import 'package:aartas_website/doctor_spotlight_page.dart';
import 'package:aartas_website/doctors_at_aartas_page.dart';
import 'package:aartas_website/footer.dart';
import 'package:aartas_website/gradient_discription.dart';
import 'package:aartas_website/landing_page.dart';
import 'package:aartas_website/review_page.dart';
import 'package:aartas_website/screens/all_doctors_screen.dart';
import 'package:aartas_website/screens/doctors_screen.dart';
import 'package:aartas_website/video_scroll_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DocProvider(),
        ),
      ],
      child: AartasApiProvider(
        child: MaterialApp(
          theme: lightThemeData(context),
          home: const HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController mainScrollController;

  bool lockMainScroll = false;

  @override
  void initState() {
    mainScrollController = ScrollController(

        // initialPage: 8,
        );
    mainScrollController.addListener(() {
      // print(mainScrollController.position.pixels);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("MainScrollLock: $lockMainScroll");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            toolbarHeight: 60,
            titleSpacing: 0,
            elevation: 2,
            shadowColor: themeData(context).colorScheme.background,
            title: GlassMorphism(
              color: themeData(context).colorScheme.background,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  mediaQuery(context).size.width > 700 ? 32 : 16,
                  0,
                  0,
                  0,
                ),
                width: mediaQuery(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage("AartasLogo.png"),
                          height:
                              mediaQuery(context).size.width > 700 ? 24 : 16,
                          color: textTheme(context).headlineSmall!.color,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        AdaptiveButton(
                          label: "Locations",
                          bgColor: Colors.transparent,
                          textColor: textTheme(context).headlineSmall!.color,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: Text("Locations"),
                              ),
                            );
                          },
                        ),
                        AdaptiveButton(
                          label: "Doctors",
                          bgColor: Colors.transparent,
                          textColor: textTheme(context).headlineSmall!.color,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AllDoctorsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Text("Download App"),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  color: burntUmberColor,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Download the Aartas-Healthcare App",
                        style: textTheme(context).titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: seaShellColor,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Image(
                        image: AssetImage("apple_logo.png"),
                        height: textTheme(context).titleSmall!.fontSize,
                        // color: seaShellColor,
                      ),
                      const SizedBox(width: 8),
                      Image(
                        image: AssetImage("play_logo.png"),
                        height: textTheme(context).labelSmall!.fontSize,
                        // color: seaShellColor,
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        CupertinoIcons.arrow_right,
                        size: textTheme(context).titleSmall!.fontSize,
                        color: seaShellColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                LandingPage(
                  controller: mainScrollController,
                ),
                GradientText(
                  controller: mainScrollController,
                ),
                DoctorsAtAartas(
                  controller: mainScrollController,
                ),
                DoctorsSpotlightPage(
                  controller: mainScrollController,
                ),
                DesignedForYou(
                  controller: mainScrollController,
                ),
              ],
            ),
          ),
          VideoScrollPage(
            controller: mainScrollController,
            isLock: (isLock) {
              // print("IsLock: $isLock");
              lockMainScroll = isLock;
              setState(() {});
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ReviewsPage(
                  controller: mainScrollController,
                ),
              ],
            ),
          ),
          AppPage(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AppPageMockups(
                  controller: mainScrollController,
                  isLock: (isLock) {
                    // print("IsLock: $isLock");
                    lockMainScroll = isLock;
                    setState(() {});
                  },
                ),
                ArticlesPage(
                  controller: mainScrollController,
                ),
                // Footer(
                //   controller: mainScrollController,
                // )
              ],
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [

          //       Container(
          //         height: mediaQuery(context).size.height,
          //         width: mediaQuery(context).size.width,
          //         color: cadetGreyColor,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var url = Uri(scheme: "tel", path: "+919999001040");
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
        child: Icon(
          CupertinoIcons.phone,
        ),
      ),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     controller: mainScrollController,
    //     slivers: [
    //       SliverToBoxAdapter(
    //         child: ScrollTransformView(
    //           children: [
    //             // LandingPage(controller: mainScrollController),
    //             ScrollTransformItem(
    //               builder: (_) {
    //                 return GradientText(
    //                   controller: mainScrollController,
    //                 );
    //               },
    //               offsetBuilder: (scrollOffset) {
    //                 print(scrollOffset);
    //                 return Offset(0, -scrollOffset);
    //               },
    //             ),
    //             ScrollTransformItem(
    //               builder: (_) {
    //                 return DoctorsSpotlightPage(
    //                   controller: mainScrollController,
    //                 );
    //               },
    //             ),
    //             ScrollTransformItem(
    //               builder: (_) {
    //                 return DesignedForYou(
    //                   controller: mainScrollController,
    //                 );
    //               },
    //             ),

    //             // DoctorsAtAartas(controller: mainScrollController),
    //           ],
    //         ),
    //       ),
    //       SliverAppBar(
    //         expandedHeight: mediaQuery(context).size.height * 3,
    //         flexibleSpace: FlexibleSpaceBar(
    //           background: Container(
    //             height: mediaQuery(context).size.height * 3,
    //             width: mediaQuery(context).size.width,
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 begin: Alignment.bottomCenter,
    //                 end: Alignment.topCenter,
    //                 colors: [
    //                   copperRedColor,
    //                   burntUmberColor,
    //                 ],
    //               ),
    //             ),
    //             child: BackgroundVideo(
    //               // mainController: mainScrollController,
    //               // lockMainScroll: lockMainScroll,
    //               networkImage:
    //                   "https://aartas-qaapp-as.azurewebsites.net/public/doctorimage/CliniShareSpaceClipforApp.mp4",
    //               // onScroll: (val) {
    //               //   lockMainScroll = val;
    //               //   setState(() {});
    //               // },
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // body: ListView(
    //   shrinkWrap: true,
    //   controller: mainScrollController,
    //   physics: lockMainScroll ? const NeverScrollableScrollPhysics() : null,
    //   children: [
    //     const LandingPage(),
    //     const GradientText(),
    //     const DoctorsAtAartas(),
    //     const DoctorsSpotlightPage(),
    //     const DesignedForYou(),
    //     Container(
    //       height: mediaQuery(context).size.height,
    //       width: mediaQuery(context).size.width,
    //       color: burntUmberColor,
    //       alignment: Alignment.center,
    //       child: Text(
    //         "Hello, Aartas!",
    //         style: textTheme(context).displaySmall,
    //       ),
    //     ),

    //   ],
    // ),
    // );
  }
}
