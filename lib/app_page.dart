import 'package:aartas_design_system/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:video_player/video_player.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("App Text");
    return SliverAppBar(
      backgroundColor: themeData(context).scaffoldBackgroundColor,
      expandedHeight: mediaQuery(context).size.height / 2.5,
      toolbarHeight: mediaQuery(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  "The Aartas App - One for All",
                  style: mediaQuery(context).size.width > 700
                      ? textTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: burntUmberColor,
                          )
                      : textTheme(context).titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: burntUmberColor,
                          ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                child: Text(
                  "Digital prescriptions\nMade simple and easy",
                  style: mediaQuery(context).size.width > 700
                      ? textTheme(context).displayMedium?.copyWith(
                            fontFamily: "TiemposHeadline",
                            fontWeight: FontWeight.w500,
                          )
                      : textTheme(context).headlineLarge?.copyWith(
                            fontFamily: "TiemposHeadline",
                            fontWeight: FontWeight.w500,
                            color: charcoalColor,
                          ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
