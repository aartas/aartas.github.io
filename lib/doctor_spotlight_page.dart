import 'dart:async';
import 'dart:math';

import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/const.dart';
import 'package:aartas_design_system/models/doctor_model.dart';
import 'package:aartas_design_system/providers/doctor_provider.dart';
import 'package:aartas_website/background_video.dart';
import 'package:aartas_website/screens/all_doctors_screen.dart';
import 'package:aartas_website/screens/doctors_screen.dart';
import 'package:aartas_website/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double videoAspectRatio(context) {
  var ar =
      mediaQuery(context).orientation == Orientation.portrait ? 3 / 4 : 10 / 4;
  return ar;
}

class DoctorsSpotlightPage extends StatelessWidget {
  final ScrollController controller;
  const DoctorsSpotlightPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // print(textTheme(context).displayMedium!.fontSize);
    debugPrint("Doctor Spotlight");
    return Container(
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
      height: mediaQuery(context).size.height,
      width: mediaQuery(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: mediaQuery(context).size.width,
                  height: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: copperRedColor,
                  ),
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    child: BackgroundVideo(
                      assetImage: "assets/2.mp4",
                      // networkImage:
                      //     "https://www.apple.com/105/media/us/supplier-responsibility/2022/de727672-85ac-447c-b50b-046919f843ef/anim/hero/medium_2x.mp4#t=5.033333",
                      loop: true,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        charcoalColor,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  width: mediaQuery(context).size.width,
                  alignment: Alignment.bottomCenter,
                  // padding: const EdgeInsets.all(32),
                  child: Container(
                    constraints: websiteWidth(context),
                    width: mediaQuery(context).size.width > 400
                        ? 1064
                        : mediaQuery(context).size.width,
                    padding: const EdgeInsets.all(32),
                    child: Wrap(
                      runSpacing: 24,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 48),
                          child: Text(
                            "It’s more than just a clinic,${mediaQuery(context).size.width > 700 ? "\n" : " "}it’s an experience for better care.",
                            style: mediaQuery(context).size.width > 700
                                ? textTheme(context).headlineLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: seaShellColor,
                                    )
                                : textTheme(context).headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: seaShellColor,
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AdaptiveButton(
                              bgColor:
                                  themeData(context).colorScheme.background,
                              textColor: textTheme(context).subtitle1!.color,
                              borderRadius: BorderRadius.circular(32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              label: "See All Doctors",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const DoctorsScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const DoctorsHorizontalList(),
        ],
      ),
    );
  }
}

class DoctorsHorizontalList extends StatefulWidget {
  const DoctorsHorizontalList({
    super.key,
  });

  @override
  State<DoctorsHorizontalList> createState() => _DoctorsHorizontalListState();
}

class _DoctorsHorizontalListState extends State<DoctorsHorizontalList> {
  late ScrollController scrollController;
  bool isLoading = false;
  double currentOffset = 0;
  late Timer? timer;
  @override
  void initState() {
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Duration dur = const Duration(milliseconds: 50);
      timer = Timer.periodic(dur, (timer) {
        print("HAS C ${scrollController.hasClients}");
        if (scrollController.hasClients) {
          scrollController.animateTo(
            timer.tick.toDouble(),
            duration: duration,
            curve: Curves.linear,
          );
          if (scrollController.position.atEdge &&
              scrollController.position.pixels != 0) {
            timer.cancel();
          }
        }
      });
    });
    fetchDoctors();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var doctorList = Provider.of<DoctorProvider>(context).getList();
    debugPrint("Doctor Horizontal List");
    return AnimatedContainer(
      duration: duration,
      height:
          mediaQuery(context).orientation == Orientation.portrait ? 250 : 300,
      width: mediaQuery(context).size.width,
      color: themeData(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: isLoading ? Alignment.center : Alignment.centerLeft,
      child: isLoading
          ? const CupertinoActivityIndicator()
          : ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: doctorList.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: listPadding(doctorList.length, i, Axis.horizontal),
                  child: DoctorCard(
                    doctor: doctorList[i],
                  ),
                );
              },
            ),
    );
  }

  fetchDoctors() {
    isLoading = true;
    setState(() {});
    Provider.of<DoctorProvider>(context, listen: false)
        .fetchList(
      baseURL,
      '',
      false,
    )
        .then((value) {
      if (value.data!.isNotEmpty) {
        Provider.of<DocProvider>(context, listen: false).addToList(value.data!);
      }
      isLoading = false;
      setState(() {});
    });
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  final DoctorData doctor;

  @override
  Widget build(BuildContext context) {
    var indexOf = doctor.doctorImages!
        .map((e) => e.section!.title)
        .toList()
        .indexOf("website");
    debugPrint("Doctor Card");
    return SizedBox(
      // height:
      //     mediaQuery(context).orientation == Orientation.portrait ? 300 : 500,
      width:
          mediaQuery(context).orientation == Orientation.portrait ? 150 : 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image(
                image: NetworkImage(
                  indexOf != -1
                      ? "${doctor.doctorImages![indexOf].image}"
                      : "$doctorImageUrl/${doctor.image}",
                ),
                fit: BoxFit.cover,
                // width: mediaQuery(context).orientation == Orientation.portrait
                //     ? 150
                //     : 200,
                // height: mediaQuery(context).orientation == Orientation.portrait
                //     ? 150
                //     : 200,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Dr. ${doctor.doctorName}",
            style: mediaQuery(context).size.width > 1000
                ? textTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: charcoalColor)
                : textTheme(context).labelMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: charcoalColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            "${doctor.speciality!.name}",
            style: mediaQuery(context).size.width > 1000
                ? textTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    )
                : textTheme(context).labelMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
