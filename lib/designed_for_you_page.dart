import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DesignedForYou extends StatelessWidget {
  final ScrollController controller;
  const DesignedForYou({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Designed for you");
    return Container(
      // height: mediaQuery(context).size.height,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(32, 32 * 4, 32, 32 * 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themeData(context).colorScheme.background,
            themeData(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              "Designed for you",
              style: mediaQuery(context).size.width > 700
                  ? textTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                  : textTheme(context)
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          FittedBox(
            child: Text(
              "Modern healthcare\nmeets modern design",
              style: mediaQuery(context).size.width > 700
                  ? textTheme(context).displayMedium?.copyWith(
                        fontFamily: "TiemposHeadline",
                        fontWeight: FontWeight.w500,
                      )
                  : textTheme(context).headlineLarge?.copyWith(
                      fontFamily: "TiemposHeadline",
                      fontWeight: FontWeight.w500,
                      color: charcoalColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: mediaQuery(context).size.width > 700
                ? 500
                : mediaQuery(context).size.width,
            child: Text(
              "A breathable modern design under soft lighting combined with elements of nature creates a pleasant atmosphere that keeps your mind fresh, relaxed and positive. How clinics should be.",
              style: mediaQuery(context).size.width > 700
                  ? textTheme(context).headlineSmall?.copyWith(height: 1.4)
                  : textTheme(context).titleLarge?.copyWith(height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          AdaptiveButton(
            label: "Take a virtual tour",
            bgColor: Colors.transparent,
            textColor: burntUmberColor,
            onTap: () {
              openUrls("https://app.cloudpano.com/tours/P2i6Gos_A");
            },
          ),
        ],
      ),
    );
  }
}

openUrls(uri) async {
  var url = Uri.parse(uri);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
