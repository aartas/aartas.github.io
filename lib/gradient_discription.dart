import 'package:aartas_design_system/const.dart';
import 'package:flutter/cupertino.dart';

class GradientText extends StatelessWidget {
  final ScrollController controller;
  const GradientText({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Gradient Text");
    return Container(
      height: mediaQuery(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            burntUmberColor,
            buffColor,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32 * 4),
      alignment: Alignment.center,
      child: SizedBox(
        width: mediaQuery(context).size.width > 700
            ? 600
            : mediaQuery(context).size.width,
        child: Text(
          "We believe in treating our patients with warmth, empathy, compassion and kindness. The quality healthcare we provide at Aartas is a reflection of our humanity.",
          style: mediaQuery(context).size.width > 700
              ? textTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeData(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.9),
                  )
              : textTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeData(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.9),
                  ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
