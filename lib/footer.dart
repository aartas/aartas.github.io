import 'package:aartas_design_system/const.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final ScrollController controller;
  const Footer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery(context).size.width,
      color: burntUmberColor,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 300,
            color: buffColor,
            child: Text("Abc"),
          ),
          Container(
            width: 300,
            color: fawnColor,
            child: Text("Abc"),
          ),
        ],
      ),
    );
  }
}
