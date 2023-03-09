import 'package:aartas_design_system/const.dart';
import 'package:flutter/cupertino.dart';

class DoctorsAtAartas extends StatelessWidget {
  final ScrollController controller;
  const DoctorsAtAartas({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // print(textTheme(context).headlineLarge!.fontSize);
    debugPrint("Doctors At Aartas");
    return Container(
      // height: mediaQuery(context).size.height,
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
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(32, 32 * 4, 32, 32 * 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              "Doctors at Aartas",
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
              "Consult with experts.\nFrom every specialty.",
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
              "We have 20+ specialties all under one roof. You can meet with them during your same visit and reduce your frequent visits to hospitals.",
              style: mediaQuery(context).size.width > 700
                  ? textTheme(context).headlineSmall?.copyWith(height: 1.4)
                  : textTheme(context).titleLarge?.copyWith(height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
