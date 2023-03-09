import 'package:aartas_design_system/const.dart';
import 'package:aartas_design_system/models/doctor_model.dart';
import 'package:aartas_design_system/providers/doctor_provider.dart';
import 'package:aartas_website/screens/all_doctors_screen.dart';
import 'package:aartas_website/screens/doctors_details_screen.dart';
import 'package:aartas_website/urls.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:card_stack_widget/widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({
    super.key,
  });

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late ScrollController scrollController;
  bool isLoading = false;
  bool startScroll = false;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    fetchList();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= mediaQuery(context).size.height) {
        startScroll = true;
        setState(() {});
      } else {
        startScroll = false;
        setState(() {});
      }
    });
  }

  fetchList() {
    var doctorsList =
        Provider.of<DoctorProvider>(context, listen: false).getList();
    if (doctorsList.isEmpty) {
      isLoading = true;
      setState(() {});
      Provider.of<DoctorProvider>(context, listen: false)
          .fetchList(baseURL, "", false)
          .then((value) {
        isLoading = false;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = false;
    if (mediaQuery(context).size.width < 700) {
      isMobile = true;
    } else {
      isMobile = false;
    }
    var doctors = Provider.of<DoctorProvider>(context).getList();
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                "Doctors Page",
                style: textTheme(context).headlineSmall,
              ),
              pinned: true,
              floating: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              expandedHeight: mediaQuery(context).size.height,
              // expandedHeight: 200,
              flexibleSpace: const FlexibleSpaceBar(
                background: Image(
                  image: AssetImage("DoctorGroup.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: isMobile
            ? AbsorbPointer(
                absorbing: !startScroll,
                child: StackedCardCarousel(
                  spaceBetweenItems: 416,
                  applyTextScaleFactor: true,
                  onPageChanged: (pageIndex) {
                    if (pageIndex == 0) {}
                  },
                  type: StackedCardCarouselType.fadeOutStack,
                  initialOffset: AppBar().preferredSize.height,
                  items: doctors.map((e) => DoctorCard(doctorData: e)).toList(),
                ),
              )
            : Container(
                width: 600,
                color: buffColor,
                child: GridView.extent(
                  maxCrossAxisExtent: 200,
                  children:
                      doctors.map((e) => DoctorCard(doctorData: e)).toList(),
                )
                // GridView.builder(
                //   shrinkWrap: true,
                //   itemCount: doctors.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     // childAspectRatio: 3.5 / 4,
                //     mainAxisSpacing: 16,
                //     crossAxisSpacing: 16,
                //     mainAxisExtent: 250,
                //     childAspectRatio: 1,
                //   ),
                //   itemBuilder: (_, i) => DoctorCard(
                //     doctorData: doctors[i],
                //   ),
                // ),
                ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctorData,
  });

  final DoctorData doctorData;

  @override
  Widget build(BuildContext context) {
    var indexOf = doctorData.doctorImages!
        .map((e) => e.section!.title)
        .toList()
        .indexOf("website");
    return InkWell(
      onTap: () {
        openDialog(context, doctorData);
      },
      child: Container(
        height: mediaQuery(context).size.width - 32,
        width: mediaQuery(context).size.width - 32,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 8,
            color: cadetGreyColor,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image(
                image: NetworkImage(
                  indexOf != -1
                      ? "${doctorData.doctorImages![indexOf].image}"
                      : "$doctorImageUrl/${doctorData.image}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
