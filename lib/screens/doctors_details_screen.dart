import 'dart:convert';

import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/components/back_button.dart';
import 'package:aartas_design_system/components/glassmorphism.dart';
import 'package:aartas_design_system/components/loading.dart';
import 'package:aartas_design_system/const.dart';
import 'package:aartas_design_system/functions/custom_chip.dart';

import 'package:aartas_design_system/functions/get_days.dart';
import 'package:aartas_design_system/models/doctor_model.dart';
import 'package:aartas_design_system/models/speciality_model.dart';
import 'package:aartas_design_system/models/timeslot_model.dart';
import 'package:aartas_design_system/providers/patient_provider.dart';
import 'package:aartas_website/designed_for_you_page.dart';
import 'package:aartas_website/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorData data;
  const DoctorDetailsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _time = "...";
  String _appointmentStatus = "...";
  Color _statusColor = cadetGreyColor;
  bool _showTime = false;
  int _selectedType = 0;

  late List<Timeslot> timeSlots = [];
  // List<dynamic> _connect(context) {
  //   return [
  //     {
  //       "name": "Call",
  //       "icon": CupertinoIcons.phone_fill,
  //       "bg": themeData(context).cardColor,
  //       "color": burntUmberColor,
  //       "onTap": () {
  //         const url = "tel:+919810366516";
  //         // openUrls(url);
  //       },
  //     },
  //     {
  //       "name": "Website",
  //       "icon": CupertinoIcons.globe,
  //       "bg": themeData(context).cardColor,
  //       "color": burntUmberColor,
  //       "onTap": () {
  //         var url = "https:${widget.data.website!}";
  //         // openUrls(url);
  //       },
  //     },
  //     // {
  //     //   "name": "Like",
  //     //   "icon": CupertinoIcons.hand_thumbsup_fill,
  //     //   "bg": burntUmberColor,
  //     //   "color": themeData(context).cardColor,
  //     //   "onTap": () {},
  //     // },
  //   ];
  // }

  late DateTime _td;
  late int _date;
  late PageController _pageController;
  final List<dynamic> _filterList = ["About", "Diseases", "Location"];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.3);
    _tabController = TabController(length: 3, vsync: this);
    var patientID =
        Provider.of<PatientProvider>(context, listen: false).getData().id;
    // getAvailableDays(widget.data.scheduleDays!);
    _td = DateTime.now();
    if (widget.data.latestTimeSlot != null) {
      _date = DateFormat("yyyy-MM-dd")
          .parse(widget.data.latestTimeSlot!.date!)
          .weekday;
    }
    if (patientID != null) {
      // getDoctorDetails(baseURL, "$patientID", "${widget.data.id}")
      //     .then((value) => timeSlots = value.data![0].timeslots!);
    }
    super.initState();
  }

  // getAvailableDays(String days) {
  //   var _timing = widget.data.timings!.first.scheduleTimings;
  //   var _dt = DateTime.now().weekday;

  //   Iterable<String> finalValue = days.split(",").map((e) {
  //     if (_dt == int.parse(e)) {
  //       _appointmentStatus = "Available Today";
  //       _statusColor = greenColor;
  //       _time = json.decode(_timing!)[e][0];
  //       setState(() {});
  //       return _appointmentStatus;
  //     } else if ((_dt == 7 ? 1 : _dt + 1) == int.parse(e)) {
  //       _statusColor = yellowColor;
  //       _appointmentStatus = "Available Tommorrow";
  //       _time = json.decode(_timing!)[e][0];
  //       setState(() {});
  //       return _appointmentStatus;
  //     } else {
  //       _appointmentStatus =
  //           "Available ${getWeekDays(int.parse(widget.data.scheduleDays!.split(",")[0]), true)}";
  //       _time = json.decode(_timing!)[e][0];
  //       _statusColor = burntUmberColor;
  //       setState(() {});
  //       return _appointmentStatus;
  //     }
  //   });
  //   log(finalValue.toString());
  // }

  @override
  Widget build(BuildContext context) {
    var patientID = Provider.of<PatientProvider>(context).getData().id;
    var imageHeight = mediaQuery(context).size.width +
        mediaQuery(context).padding.top +
        AppBar().preferredSize.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: imageHeight,
            leading: const BButton(),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: "${widget.data.image}",
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        // height: imageHeight,
                        imageUrl: "$doctorImageUrl/${widget.data.image}",
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
              // title: Text(
              //   "Dr. ${widget.data.doctorName}",
              //   style: textTheme(context).headline6,
              // ),
              // background: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [],
              // ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                color: themeData(context).backgroundColor,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. ${widget.data.doctorName}",
                                style: textTheme(context)
                                    .headline6!
                                    .apply(fontWeightDelta: 2),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${widget.data.degreeSuffix}",
                                style: textTheme(context)
                                    .subtitle1
                                    ?.apply(fontWeightDelta: 1),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8),
                              // Text(
                              //   "$rupeeIcon${widget.data.consulationFee}",
                              //   style: textTheme(context).subtitle2,
                              // ),
                              // const SizedBox(height: 4),
                              // widget.data.latestTimeSlot != null
                              //     ? getAvailability(context,
                              //         widget.data.latestTimeSlot!.date!)
                              //     : const SizedBox(),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(0, 16, 8, 16),
                              //   child: Row(
                              //     children: [
                              //       Image(
                              //         image: NetworkImage(
                              //           "$iconImageUrl/${widget.data.speciality!.iconUrl}",
                              //         ),
                              //         height: textTheme(context)
                              //             .headline6!
                              //             .fontSize,
                              //         // color:
                              //         //     textTheme(context).headline6!.color,
                              //       ),
                              //       Expanded(
                              //         child: Text(
                              //           "   ${widget.data.speciality!.name}",
                              //           style: textTheme(context)
                              //               .subtitle1
                              //               ?.apply(fontWeightDelta: 2),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        CustomChip(
                          backgroundColor: cadetBlueColor,
                          child: Text(
                            "${widget.data.speciality!.name}",
                            style: textTheme(context)
                                .subtitle1!
                                .apply(fontWeightDelta: 2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 60,
                      color: themeData(context).backgroundColor,
                      padding: const EdgeInsets.fromLTRB(0, 2, 16, 2),
                      alignment: Alignment.center,
                      child: PageView.builder(
                        padEnds: false,
                        controller: _pageController,
                        itemCount: _filterList.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () {
                              _selectedType = i;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                              decoration: BoxDecoration(
                                color: _selectedType == i
                                    ? textTheme(context).subtitle1!.color
                                    : themeData(context)
                                        .scaffoldBackgroundColor,
                                border: Border.all(
                                  color: textTheme(context).subtitle1!.color!,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${_filterList[i]}",
                                style: textTheme(context).subtitle1?.apply(
                                      fontWeightDelta: 1,
                                      color: _selectedType == i
                                          ? themeData(context)
                                              .scaffoldBackgroundColor
                                          : null,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _selectedType == 0
                ? AboutPage(doctorData: widget.data)
                : _selectedType == 1
                    ? Diseases(speciality: widget.data.speciality!)
                    : Locations(doctorData: widget.data),
          )
        ],
      ),
      bottomNavigationBar: GlassMorphism(
        color: themeData(context).scaffoldBackgroundColor,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              mediaQuery(context).padding.bottom != 0
                  ? mediaQuery(context).padding.bottom
                  : 16),
          child: AdaptiveButton(
            label: widget.data.latestTimeSlot != null
                ? "Book Appointment"
                : "No Slots Available",
            onTap: widget.data.latestTimeSlot != null
                ? () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BookAppointment(
                    //       data: widget.data,
                    //       timeSlots: const [],
                    //       fees: widget.data.consulationFee,
                    //     ),
                    //   ),
                    // );
                  }
                : null,
          ),
        ),
      ),
    );
    // return Scaffold(
    //   extendBody: true,
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         pinned: true,
    //         expandedHeight: mediaQuery(context).size.width + 72,
    //         leading: const BButton(),
    //         stretch: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           stretchModes: const [StretchMode.zoomBackground],
    //           collapseMode: CollapseMode.parallax,
    //           centerTitle: true,
    //           background: Column(
    //             children: [
    //               Hero(
    //                 tag: "${widget.data.image}",
    //                 child: CachedNetworkImage(
    //                   fit: BoxFit.cover,
    //                   height: mediaQuery(context).size.width,
    //                   imageUrl: "$doctorImageUrl/${widget.data.image}",
    //                   errorWidget: (context, url, error) => const SizedBox(),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           // title: Text(
    //           //  "Dr. ${widget.data.doctorName}",
    //           // style: textTheme(context).headline6,
    //           //),
    //           // background: Column(
    //           //   mainAxisAlignment: MainAxisAlignment.end,
    //           //   children: [
    //           //   ],
    //           // ),
    //         ),
    //         bottom: PreferredSize(
    //           preferredSize: const Size.fromHeight(100),
    //           child: Container(
    //             color: themeData(context).backgroundColor,
    //             padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Expanded(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "Dr. ${widget.data.doctorName}",
    //                             style: textTheme(context)
    //                                 .headline6!
    //                                 .apply(fontWeightDelta: 2),
    //                           ),
    //                           const SizedBox(height: 4),
    //                           Text(
    //                             "${widget.data.degreeSuffix}",
    //                             style: textTheme(context)
    //                                 .subtitle1
    //                                 ?.apply(fontWeightDelta: 1),
    //                             maxLines: 2,
    //                           ),
    //                           const SizedBox(height: 8),
    //                           // Text(
    //                           //   "$rupeeIcon${widget.data.consulationFee}",
    //                           //   style: textTheme(context).subtitle2,
    //                           // ),
    //                           // const SizedBox(height: 4),
    //                           // widget.data.latestTimeSlot != null
    //                           //     ? getAvailability(context,
    //                           //         widget.data.latestTimeSlot!.date!)
    //                           //     : const SizedBox(),
    //                           // Padding(
    //                           //   padding:
    //                           //       const EdgeInsets.fromLTRB(0, 16, 8, 16),
    //                           //   child: Row(
    //                           //     children: [
    //                           //       Image(
    //                           //         image: NetworkImage(
    //                           //           "$iconImageUrl/${widget.data.speciality!.iconUrl}",
    //                           //         ),
    //                           //         height: textTheme(context)
    //                           //             .headline6!
    //                           //             .fontSize,
    //                           //         // color:
    //                           //         //     textTheme(context).headline6!.color,
    //                           //       ),
    //                           //       Expanded(
    //                           //         child: Text(
    //                           //           "   ${widget.data.speciality!.name}",
    //                           //           style: textTheme(context)
    //                           //               .subtitle1
    //                           //               ?.apply(fontWeightDelta: 2),
    //                           //         ),
    //                           //       ),
    //                           //     ],
    //                           //   ),
    //                           // ),
    //                         ],
    //                       ),
    //                     ),
    //                     CustomChip(
    //                       child: Text(
    //                         "${widget.data.speciality!.name}",
    //                         style: textTheme(context)
    //                             .subtitle1!
    //                             .apply(fontWeightDelta: 2),
    //                       ),
    //                       backgroundColor: cadetBlueColor,
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(
    //                   height: 4,
    //                 ),
    //                 Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: TabBar(
    //                     controller: _tabController,
    //                     indicatorSize: TabBarIndicatorSize.label,
    //                     labelPadding: const EdgeInsets.symmetric(vertical: 8),
    //                     automaticIndicatorColorAdjustment: true,
    //                     isScrollable: true,
    //                     labelColor: themeData(context).scaffoldBackgroundColor,
    //                     unselectedLabelColor:
    //                         textTheme(context).headline6!.color,
    //                     enableFeedback: true,
    //                     indicator: BoxDecoration(
    //                       color: textTheme(context).subtitle1!.color!,
    //                       borderRadius: BorderRadius.circular(30),
    //                     ),
    //                     labelStyle: textTheme(context)
    //                         .subtitle1
    //                         ?.apply(fontWeightDelta: 2),
    //                     tabs: [
    //                       // "Appointments",
    //                       "About",
    //                       "Diseases",
    //                       "Location",
    //                     ]
    //                         .map(
    //                           (e) => Padding(
    //                             padding:
    //                                 const EdgeInsets.symmetric(horizontal: 16),
    //                             child: Text(e),
    //                           ),
    //                         )
    //                         .toList(),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       SliverFillRemaining(
    //         hasScrollBody: true,
    //         fillOverscroll: false,
    //         child: TabBarView(
    //           // physics: const NeverScrollableScrollPhysics(),
    //           controller: _tabController,
    //           children: [
    //             // DateList(data: widget.data, timeSlots: const []),
    //             AboutPage(doctorData: widget.data),
    //             Diseases(speciality: widget.data.speciality!),
    //             Locations(doctorData: widget.data),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    //   bottomNavigationBar: GlassMorphism(
    //     color: themeData(context).scaffoldBackgroundColor,
    //     child: Container(
    //       padding: EdgeInsets.fromLTRB(
    //           16,
    //           16,
    //           16,
    //           mediaQuery(context).padding.bottom != 0
    //               ? mediaQuery(context).padding.bottom
    //               : 16),
    //       child: AdaptiveButton(
    //         label: "Book Appointment",
    //         onTap: () {
    //           showCustomBottomSheet(
    //             context,
    //             "Dr. ${widget.data.doctorName}",
    //             [
    //               SizedBox(
    //                 height: (mediaQuery(context).size.height * 0.8) -
    //                     AppBar().preferredSize.height,
    //                 child: DateList(
    //                   data: widget.data,
    //                   timeSlots: const [],
    //                   fees: widget.data.consulationFee,
    //                 ),
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   body: NestedScrollView(
    //     headerSliverBuilder: (context, innerBoxIsScrolled) {
    //       return [
    //         SliverAppBar(
    //           pinned: true,
    //           expandedHeight: mediaQuery(context).size.width + 8,
    //           leading: const BButton(),
    //           flexibleSpace: FlexibleSpaceBar(
    //             stretchModes: const [StretchMode.zoomBackground],
    //             collapseMode: CollapseMode.parallax,
    //             centerTitle: true,
    //             background: Column(
    //               children: [
    //                 Hero(
    //                   tag: "${widget.data.image}",
    //                   child: CachedNetworkImage(
    //                     fit: BoxFit.cover,
    //                     imageUrl: "$doctorImageUrl/${widget.data.image}",
    //                     errorWidget: (context, url, error) => const SizedBox(),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // title: Text(
    //             //  "Dr. ${widget.data.doctorName}",
    //             // style: textTheme(context).headline6,
    //             //),
    //             // background: Column(
    //             //   mainAxisAlignment: MainAxisAlignment.end,
    //             //   children: [
    //             //     Row(
    //             //       crossAxisAlignment: CrossAxisAlignment.end,
    //             //       children: [
    //             //         Expanded(
    //             //           child: Padding(
    //             //             padding:
    //             //                 const EdgeInsets.only(left: 16.0, right: 8.0),
    //             //             child: Column(
    //             //               mainAxisAlignment: MainAxisAlignment.end,
    //             //               crossAxisAlignment: CrossAxisAlignment.start,
    //             //               children: [
    //             //                 Text(
    //             //                   "Dr. ${widget.data.doctorName}",
    //             //                   style: textTheme(context)
    //             //                       .headline6!
    //             //                       .apply(fontWeightDelta: 1),
    //             //                 ),
    //             //                 const SizedBox(height: 4),
    //             //                 Text(
    //             //                   "${widget.data.degreeSuffix}",
    //             //                   style: textTheme(context).subtitle2,
    //             //                   maxLines: 2,
    //             //                 ),
    //             //                 const SizedBox(height: 4),
    //             //                 Text(
    //             //                   "$rupeeIcon${widget.data.consulationFee}",
    //             //                   style: textTheme(context).subtitle2,
    //             //                 ),
    //             //                 const SizedBox(height: 4),
    //             //                 widget.data.latestTimeSlot != null
    //             //                     ? getAvailability(context,
    //             //                         widget.data.latestTimeSlot!.date!)
    //             //                     : const SizedBox(),
    //             //                 Padding(
    //             //                   padding:
    //             //                       const EdgeInsets.fromLTRB(0, 16, 8, 16),
    //             //                   child: Row(
    //             //                     children: [
    //             //                       Image(
    //             //                         image: NetworkImage(
    //             //                           "$iconImageUrl/${widget.data.speciality!.iconUrl}",
    //             //                         ),
    //             //                         height: textTheme(context)
    //             //                             .headline6!
    //             //                             .fontSize,
    //             //                         // color:
    //             //                         //     textTheme(context).headline6!.color,
    //             //                       ),
    //             //                       Expanded(
    //             //                         child: Text(
    //             //                           "   ${widget.data.speciality!.name}",
    //             //                           style: textTheme(context)
    //             //                               .subtitle1
    //             //                               ?.apply(fontWeightDelta: 2),
    //             //                         ),
    //             //                       ),
    //             //                     ],
    //             //                   ),
    //             //                 ),
    //             //               ],
    //             //             ),
    //             //           ),
    //             //         ),
    //             //       ],
    //             //     ),
    //             //   ],
    //             // ),
    //           ),
    //           bottom: PreferredSize(
    //             child: Padding(
    //               padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: TabBar(
    //                   controller: _tabController,
    //                   indicatorSize: TabBarIndicatorSize.label,
    //                   labelPadding: const EdgeInsets.symmetric(vertical: 8),
    //                   automaticIndicatorColorAdjustment: true,
    //                   isScrollable: true,
    //                   labelColor: themeData(context).scaffoldBackgroundColor,
    //                   unselectedLabelColor: textTheme(context).headline6!.color,
    //                   enableFeedback: true,
    //                   indicator: BoxDecoration(
    //                     color: textTheme(context).subtitle1!.color!,
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   labelStyle: textTheme(context)
    //                       .subtitle1
    //                       ?.apply(fontWeightDelta: 2),
    //                   tabs: [
    //                     // "Appointments",
    //                     "About",
    //                     "Diseases",
    //                     "Location",
    //                   ]
    //                       .map(
    //                         (e) => Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 16),
    //                           child: Text(e),
    //                         ),
    //                       )
    //                       .toList(),
    //                 ),
    //               ),
    //             ),
    //             preferredSize: const Size.fromHeight(60),
    //           ),
    //         ),
    //       ];
    //     },
    //     body: CustomScrollView(
    //       slivers: [],
    //     ),
    //   ),
    // );
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       // backgroundColor: themeData(context).scaffoldBackgroundColor,

//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             elevation: 0,
//             // backgroundColor: Colors.transparent,
//             leading: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CircleAvatar(
//                 backgroundColor: themeData(context).backgroundColor,
//                 child: IconButton(
//                   padding: EdgeInsets.zero,
//                   icon: const Icon(Icons.arrow_back),
//                   color: textTheme(context).headline6?.color,
//                   iconSize: 24,
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             ),
//             backgroundColor: themeData(context).scaffoldBackgroundColor,
//             // pinned: true,
//             expandedHeight: 200,
//             flexibleSpace: FlexibleSpaceBar(
//               stretchModes: const [StretchMode.zoomBackground],
//               collapseMode: CollapseMode.parallax,
//               centerTitle: true,
//               // title: Text(
//               //  "Dr. ${widget.data.doctorName}",
//               // style: textTheme(context).headline6,
//               //),
//               background: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
// //                fit: StackFit.expand,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 16.0, right: 8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Dr. ${widget.data.doctorName}",
//                             style: textTheme(context)
//                                 .headline5!
//                                 .apply(fontWeightDelta: 1),
//                           ),
//                           const SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             "${widget.data.degreeSuffix}",
//                             style: textTheme(context).subtitle1,
//                             maxLines: 2,
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             "$rupeeIcon${widget.data.consulationFee}",
//                             style: textTheme(context).headline6,
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Hero(
//                     tag: "${widget.data.image}",
//                     child: CachedNetworkImage(
//                       width: 180,
//                       fit: BoxFit.cover,
//                       imageUrl: "$doctorImageUrl/${widget.data.image}",
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.person),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // SliverToBoxAdapter(
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(16.0),
//           //     child: Column(
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Text(
//           //           "${widget.data.speciality!.name}",
//           //           style: textTheme(context).headline6,
//           //         ),
//           //         Text(
//           //           "${widget.data.degreeSuffix}",
//           //           style: textTheme(context).subtitle1,
//           //           maxLines: 2,
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           // SliverToBoxAdapter(
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(16),
//           //     child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       crossAxisAlignment: CrossAxisAlignment.center,
//           //       children: _connect(context)
//           //           .map((e) => Expanded(
//           //                 child: GestureDetector(
//           //                   onTap: e['onTap'],
//           //                   child: Padding(
//           //                     padding: defaultHorizontalPadding / 3,
//           //                     child: Row(
//           //                         mainAxisAlignment: MainAxisAlignment.center,
//           //                         children: [
//           //                           Icon(
//           //                             e['icon'],
//           //                             color: e['color'],
//           //                           ),
//           //                           const SizedBox(
//           //                             width: 8,
//           //                           ),
//           //                           FittedBox(
//           //                             child: Text(
//           //                               e['name'],
//           //                               style: textTheme(context)
//           //                                   .subtitle1
//           //                                   ?.apply(color: e['color']),
//           //                             ),
//           //                           ),
//           //                         ]),
//           //                   ),
//           //                 ),
//           //               ))
//           //           .toList(),
//           //     ),
//           //   ),
//           // ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 24.0),
//               child: DateList(
//                 data: widget.data,
//                 timeSlots: const [],
//               ),
//             ),
//           ),
//           // SliverToBoxAdapter(
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(16),
//           //     child: Row(
//           //       children: [
//           //         CupertinoButton(
//           //           padding:
//           //               const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           //           color: burntUmberColor,
//           //           child: const Text("Book Appointment"),
//           //           onPressed: () {
//           //             loading(context, "", null);
//           //             var value =
//           //                 Provider.of<PatientProvider>(context, listen: false)
//           //                     .getData();
//           //             customEvent(
//           //               "${value.id}",
//           //               "6",
//           //               "",
//           //               "",
//           //               "${widget.data.id}",
//           //               "",
//           //             );
//           //             Navigator.pop(context);
//           //             Navigator.push(
//           //               context,
//           //               MaterialPageRoute(
//           //                 builder: (_) => BookAppointment(
//           //                   type: "Book Appointment",
//           //                   data: widget.data,
//           //                   timeSlots: timeSlots,
//           //                 ),
//           //               ),
//           //             );
//           //           },
//           //         )
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           SliverToBoxAdapter(
//             child: widget.data.procedure!.isNotEmpty
//                 ? Padding(
//                     padding: subHeadingPadding,
//                     child: ListTile(
//                       onTap: () {
//                         showModalBottomSheet(
//                           backgroundColor:
//                               themeData(context).scaffoldBackgroundColor,
//                           isScrollControlled: false,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(borderRadius),
//                             ),
//                           ),
//                           context: context,
//                           builder: (_) => SafeArea(
//                             top: true,
//                             child: ProcedureAndTreatmentPage(widget: widget),
//                           ),
//                         );
//                       },
//                       title: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 CupertinoIcons.square_list_fill,
//                                 color: burntUmberColor,
//                               ),
//                               Text(
//                                 "  Procedures & Treatments",
//                                 style: textTheme(context)
//                                     .subtitle1
//                                     ?.apply(color: pearlColor),
//                               ),
//                             ],
//                           ),
//                           // Text(widget.data.sc)
//                         ],
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ),
//           SliverToBoxAdapter(
//             child: Divider(
//               color: textTheme(context).headline6?.color,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
//               child: Text(
//                 "Timings",
//                 style: textTheme(context).headline6,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: widget.data.latestTimeSlot != null
//                 ? Padding(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     child: widget.data.latestTimeSlot != null
//                         ? getAvailability(
//                             context, widget.data.latestTimeSlot!.date!)
//                         : const SizedBox(),
//                   )
//                 : const SizedBox(),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: widget.data.timings != null
//                   ? widget.data.timings!.first.scheduleDays!
//                       .split(",")
//                       .map(
//                         (e) => ListTile(
//                           minVerticalPadding: 0,
//                           title: Text(
//                             getWeekDays(int.parse(e), true),
//                             style: textTheme(context).subtitle1,
//                           ),
//                           subtitle: Text(
//                             "${get24to12(json.decode(widget.data.timings!.first.scheduleTimings!)[e][0])}",
//                             style: textTheme(context).subtitle2,
//                           ),
//                         ),
//                       )
//                       .toList()
//                   : [],
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Divider(
//               color: textTheme(context).headline6?.color,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
//               child: Text(
//                 "Details",
//                 style: textTheme(context).headline6,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 {
//                   "description": "Registration Number",
//                   "value": "${widget.data.registrationNum}"
//                 },
//                 {
//                   "description": "Experience",
//                   "value": "${widget.data.totalExperience}+ Years"
//                 },
//                 {
//                   "description": "Languages Known",
//                   "value": "${widget.data.languages}"
//                 },
//               ]
//                   .map(
//                     (e) => ListTile(
//                       title: Text("${e['description']}"),
//                       subtitle: Text("${e['value']}"),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Divider(
//               color: textTheme(context).headline6?.color,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
//               child: Text(
//                 "Clinic Address",
//                 style: textTheme(context).headline6,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '18A Ring Road,\nLajpat Nagar-4\nNew Delhi\n110024',
//                     style: textTheme(context).subtitle1,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       const url = "https://goo.gl/maps/xLFWDcuUfk6uPWXw9";
//                       // openUrls(url);
//                     },
//                     icon: Icon(
//                       CupertinoIcons.arrow_up_right_diamond_fill,
//                       color: burntUmberColor,
//                       size: 32,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Divider(
//               color: textTheme(context).headline6?.color,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Text(
//                 "Condition Treated by the doctor",
//                 style: textTheme(context).headline6,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: widget.data.speciality!.conditions != null
//                 ? ListView.builder(
//                     itemCount: widget.data.speciality!.conditions
//                         .toString()
//                         .split(",")
//                         .toList()
//                         .length,
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     primary: false,
//                     itemBuilder: (_, i) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.only(right: 16 / 2),
//                                 child: Icon(
//                                   CupertinoIcons.hand_point_right_fill,
//                                   size: Theme.of(context)
//                                       .textTheme
//                                       .subtitle1!
//                                       .fontSize,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                                 child: Text(
//                               widget.data.speciality!.conditions
//                                   .toString()
//                                   .split(",")
//                                   .toList()[i]
//                                   .trim(),
//                               style: Theme.of(context).textTheme.subtitle1,
//                             )),
//                           ],
//                         ),
//                       );
//                     },
//                   )
//                 : const SizedBox(),
//           ),
//           const SliverToBoxAdapter(
//             child: const SizedBox(height: 150),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: Container(
//       //   decoration: BoxDecoration(
//       //       color: themeData(context).scaffoldBackgroundColor,
//       //       borderRadius:
//       //           BorderRadius.vertical(top: Radius.circular(borderRadius)),
//       //       boxShadow: <BoxShadow>[
//       //         BoxShadow(color: blackColor, blurRadius: 10)
//       //       ]),
//       //   padding: EdgeInsets.fromLTRB(
//       //     16,
//       //     16 / 2,
//       //     16,
//       //     16 * 1.5,
//       //   ),
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     mainAxisSize: MainAxisSize.min,
//       //     children: [
//       //       Text(
//       //         "Consultation Fee: ₹${widget.data.consulationFee}",
//       //         style: textTheme(context)
//       //             .subtitle1
//       //             ?.apply(color: burntUmberColor, fontWeightDelta: 1),
//       //       ),
//       //       Container(
//       //         padding: EdgeInsets.only(bottom: 16 / 4),
//       //         child: Text(
//       //           "Avg. time per consult: ${widget.data.timePerPatient} min",
//       //           style: textTheme(context).subtitle1?.apply(color: pearlColor),
//       //         ),
//       //       ),
//       //       AdaptiveButton(
//       //         label: "Book Appointment",
//       //         onTap: () {
//       //           loading(context, "", null);
//       //           getProfileDetails().then(
//       //             (value) => customEvent(
//       //               "${value.data![0].id}",
//       //               "6",
//       //               "",
//       //               "",
//       //               "${widget.data.id}",
//       //               "",
//       //             ),
//       //           );
//       //           Navigator.pop(context);
//       //           showModalBottomSheet(
//       //             isScrollControlled: true,
//       //             backgroundColor: themeData(context).scaffoldBackgroundColor,
//       //             clipBehavior: Clip.hardEdge,
//       //             shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.vertical(
//       //                 top: Radius.circular(borderRadius),
//       //               ),
//       //             ),
//       //             context: context,
//       //             builder: (_) => BookAppointment(
//       //                 type: "Book Appointment", data: widget.data),
//       //           );
//       //         },
//       //       ),
//       //       // SizedBox(
//       //       //   height: 16,
//       //       // )
//       //     ],
//       //   ),
//       // ),
//     );
  }
}

class Locations extends StatelessWidget {
  final DoctorData doctorData;
  const Locations({
    Key? key,
    required this.doctorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> clinicFeatureslist = [
      {
        "icon": Icons.local_parking_rounded,
        "label": "Parking Available",
        "tag": null
      },
      {
        "icon": Icons.wheelchair_pickup_rounded,
        "label": "Wheelchair Access",
        "tag": null
      },
      {
        "icon": Icons.elevator_rounded,
        "label": "Elevator Available",
        "tag": null,
      },
      {
        "icon": Icons.wifi,
        "label": "Wi-Fi Accessible",
        "tag": null,
      },
      {
        // "icon": CupertinoIcons.,
        "label": "Pharmacy on primise",
        "tag": null
      },
      {
        "icon": Icons.coffee_outlined,
        "label": "Complementary tea, coffee",
        "tag": null
      },
      {
        "icon": CupertinoIcons.star_circle,
        "label": "Other specialties available",
        "tag": null
      },
    ];
    List<dynamic> covidPolicy = [
      {
        "icon": Icons.masks_outlined,
        "title": "Face Shield",
        "subtitle": "Compulsory use of face mask."
      },
      {
        "icon": Icons.error_outline_outlined,
        "title": "Temperature Check",
        "subtitle":
            "We may undertake a temperature check to triage as per protocols."
      },
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: themeData(context).backgroundColor,
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 4),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: textTheme(context)
                            .subtitle1
                            ?.apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "18-A Ring Road,\nLajpat Nagar 4,\nNew Delhi-110024",
                        style: textTheme(context).subtitle2,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: textTheme(context).headline6!.color!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.location_on_rounded),
                )
              ],
            ),
          ),
          Container(
            color: themeData(context).backgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    "Clinic Features",
                    style:
                        textTheme(context).subtitle1?.apply(fontWeightDelta: 2),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: clinicFeatureslist.length,
                  itemBuilder: (_, i) => Padding(
                    padding: listPadding(
                        clinicFeatureslist.length, i, Axis.vertical),
                    child: Row(
                      children: [
                        clinicFeatureslist[i]['icon'] != null
                            ? Icon(clinicFeatureslist[i]['icon'])
                            : Image(
                                image: const AssetImage('assets/pills.png'),
                                width: 24,
                                height: 24,
                                color: textTheme(context).subtitle1!.color,
                              ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "${clinicFeatureslist[i]['label']}",
                              style: textTheme(context)
                                  .subtitle1
                                  ?.apply(fontWeightDelta: 1),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            clinicFeatureslist[i]['tag'] != null
                                ? CustomChip(
                                    backgroundColor: cadetGreyColor,
                                    child: Text(
                                      "${clinicFeatureslist[i]['tag']}",
                                      style: textTheme(context)
                                          .subtitle2!
                                          .apply(fontWeightDelta: 1),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: themeData(context).backgroundColor,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    "COVID 19 Policy",
                    style:
                        textTheme(context).subtitle1?.apply(fontWeightDelta: 2),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: covidPolicy.length,
                  itemBuilder: (_, i) => Padding(
                    padding: listPadding(covidPolicy.length, i, Axis.vertical),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(covidPolicy[i]['icon']),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${covidPolicy[i]['title']}",
                                style: textTheme(context)
                                    .subtitle1
                                    ?.apply(fontWeightDelta: 1),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${covidPolicy[i]['subtitle']}",
                                style: textTheme(context).bodyText1?.apply(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Diseases extends StatelessWidget {
  final Speciality? speciality;

  const Diseases({Key? key, this.speciality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return speciality!.conditions != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              color: themeData(context).backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Common Condition Treated",
                      style: textTheme(context)
                          .subtitle1
                          ?.apply(fontWeightDelta: 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ListView.separated(
                      itemCount: speciality!.conditions
                          .toString()
                          .split(",")
                          .toList()
                          .length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // FittedBox(
                              //   fit: BoxFit.scaleDown,
                              //   child: Padding(
                              //     padding: EdgeInsets.only(right: 8),
                              //     child: Icon(
                              //       CupertinoIcons.check_mark_circled,
                              //       size: Theme.of(context)
                              //           .textTheme
                              //           .subtitle1!
                              //           .fontSize,
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Text(
                                  speciality!.conditions
                                      .toString()
                                      .split(",")
                                      .toList()[i]
                                      .trim(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.apply(fontWeightDelta: 1),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, i) {
                        return const Divider(
                          height: 16,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

class AboutPage extends StatelessWidget {
  final DoctorData? doctorData;
  const AboutPage({
    Key? key,
    this.doctorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 8,
        ),
        Container(
          color: themeData(context).backgroundColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "More about this doctor",
                style: textTheme(context).subtitle1?.apply(fontWeightDelta: 2),
              ),
              const SizedBox(height: 16),
              doctorData!.latestTimeSlot == null
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        // showCustomBottomSheet(
                        //   context,
                        //   // "Schedule",
                        //   null,
                        //   [
                        //     doctorData!.latestTimeSlot != null
                        //         ? Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 16, vertical: 16),
                        //             child: getAvailability(context,
                        //                 doctorData!.latestTimeSlot!.date!),
                        //           )
                        //         : const SizedBox(),
                        //     Column(
                        //       children: doctorData!.timings != null
                        //           ? doctorData!.timings!.first.scheduleDays!
                        //               .split(",")
                        //               .map(
                        //                 (e) => Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                     horizontal: 16,
                        //                     vertical: 4.0,
                        //                   ),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     textBaseline:
                        //                         TextBaseline.ideographic,
                        //                     children: [
                        //                       Text(
                        //                         getWeekDays(int.parse(e), true),
                        //                         style: textTheme(context)
                        //                             .subtitle1
                        //                             ?.apply(fontWeightDelta: 1),
                        //                       ),
                        //                       Text(
                        //                         "${get24to12(json.decode(doctorData!.timings!.first.scheduleTimings!)[e][0])}",
                        //                         style: textTheme(context)
                        //                             .subtitle1
                        //                             ?.apply(fontWeightDelta: 1),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               )
                        //               .toList()
                        //           : [],
                        //     ),
                        //     const SizedBox(
                        //       height: 16,
                        //     )
                        //   ],
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: textTheme(context)
                                  .subtitle1!
                                  .color!
                                  .withOpacity(0.05),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.calendar,
                              color: themeData(context).iconTheme.color,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // getAvailability(
                                    //   context,
                                    //   "${doctorData!.latestTimeSlot!.date}",
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(
                                        CupertinoIcons.circle_fill,
                                        size: 6,
                                        color: textTheme(context)
                                            .subtitle1!
                                            .color!
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      "View Schedule",
                                      style:
                                          textTheme(context).subtitle2?.apply(
                                                fontWeightDelta: 2,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${DateFormat.jm().format(DateFormat("HH:mm").parse("${doctorData!.latestTimeSlot!.timeFrom}"))}  to  ${DateFormat.jm().format(DateFormat("HH:mm").parse("${doctorData!.latestTimeSlot!.timeTo}"))}",
                                  style: textTheme(context)
                                      .subtitle1
                                      ?.apply(fontWeightDelta: 1),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              Column(
                children: <dynamic>[
                  {
                    "icon": Icon(
                      CupertinoIcons.location,
                      color: themeData(context).iconTheme.color,
                      size: 24,
                    ),
                    "value": "18A Ring Road, Lajpat Nagar 4",
                    "label": "Aartas",
                  },
                  {
                    // "icon": Image(
                    //   image: const AssetImage("assets/stethoscope.png"),
                    //   color: themeData(context).iconTheme.color,
                    //   width: 24,
                    //   height: 24,
                    // ),
                    "icon": Icon(
                      CupertinoIcons.checkmark_shield,
                      color: themeData(context).iconTheme.color,
                      size: 24,
                    ),
                    "label": null,
                    "value":
                        "${doctorData!.totalExperience}+ years of experience",
                  },
                  {
                    "icon": Icon(
                      Icons.currency_rupee_sharp,
                      color: themeData(context).iconTheme.color,
                      size: 24,
                    ),
                    "label": null,
                    "value":
                        "$rupee${doctorData!.consulationFee} Consultation Fee",
                  },
                ]
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: textTheme(context)
                                  .subtitle1!
                                  .color!
                                  .withOpacity(0.05),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            e['icon'],
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                e['label'] != null
                                    ? Text(
                                        "${e['label']}",
                                        style: textTheme(context)
                                            .subtitle1
                                            ?.apply(fontWeightDelta: 1),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 4,
                                ),
                                e['value'] != null
                                    ? Text(
                                        "${e['value']}",
                                        style: textTheme(context)
                                            .subtitle1
                                            ?.apply(fontWeightDelta: 1),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        // Social(doctorData: doctorData),
      ],
    );
  }
}

class Social extends StatelessWidget {
  const Social({
    Key? key,
    required this.doctorData,
  }) : super(key: key);

  final DoctorData? doctorData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData(context).backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <dynamic>[
          {
            "icon": CupertinoIcons.globe,
            "label": "Website",
            "ontap": doctorData!.website != null
                ? () {
                    var url = "https:${doctorData!.website}";
                    openUrls(url);
                  }
                : null,
          },
          {
            "icon": CupertinoIcons.phone,
            "label": "Call",
            "ontap": doctorData!.appointmentPhoneNumber != null
                ? () {
                    var url = "tel:${doctorData!.appointmentPhoneNumber}";
                    openUrls(url);
                  }
                : null,
          },
          {
            "icon": Icons.facebook,
            "label": "Instagram",
            "ontap": doctorData!.instagram != null
                ? () {
                    openUrls(doctorData!.instagram);
                  }
                : null,
          },
          {
            "icon": CupertinoIcons.money_yen,
            "label": "Youtube",
            "ontap": doctorData!.facebook != null
                ? () {
                    openUrls(doctorData!.facebook);
                  }
                : null,
          },
        ]
            .map(
              (e) => Expanded(
                child: AbsorbPointer(
                  absorbing: e['ontap'] == null,
                  child: Opacity(
                    opacity: e['ontap'] == null ? 0.3 : 1,
                    child: InkWell(
                      onTap: () {
                        e['ontap']();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                themeData(context).scaffoldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: FittedBox(
                                child: Icon(
                                  e['icon'],
                                  size: 24,
                                  color: burntUmberColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${e['label']}",
                            style: textTheme(context).subtitle2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final List<dynamic> list;

  const Details({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, i) => Padding(
        padding: defaultHorizontalPadding / 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              list[i]['description'],
              style: textTheme(context).subtitle2?.apply(
                    color: themeData(context).backgroundColor.withOpacity(0.4),
                  ),
            ),
            Text(
              list[i]['value'],
              style: textTheme(context).subtitle1?.apply(
                    color: pearlColor,
                  ),
            ),
          ],
        ),
      ),
      separatorBuilder: (_, i) => SizedBox(
        height: 16 / 3,
      ),
    );
  }
}

class ProcedureAndTreatmentPage extends StatelessWidget {
  const ProcedureAndTreatmentPage({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DoctorDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Procedures & Treatments",
                style: textTheme(context).headline6?.apply(
                      color: pearlColor,
                      fontWeightDelta: 1,
                    ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.clear_circled))
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.data.procedure!.length,
          itemBuilder: (_, i) => Padding(
            padding: listPadding(
              widget.data.procedure!.length,
              i,
              Axis.vertical,
            ),
            child: CommonCard(
              child: Padding(
                padding: EdgeInsets.all(16 / 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.data.procedure![i].title!,
                                style: textTheme(context).headline6?.apply(
                                      fontWeightDelta: 1,
                                      color: burntUmberColor,
                                    ),
                                maxLines: 3,
                              ),
                              Text(
                                "No. of session: ${widget.data.procedure![i].totalSessions!}",
                                style: textTheme(context).subtitle1?.apply(
                                      color: pearlColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        widget.data.procedure![i].showCost == 1
                            ? Padding(
                                padding: EdgeInsets.only(left: 16 / 1.5),
                                child: Text(
                                  "$rupeeIcon${widget.data.procedure![i].cost!}",
                                  style: textTheme(context).headline6?.apply(
                                        color: burntUmberColor,
                                        fontWeightDelta: 1,
                                      ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Text(
                      widget.data.procedure![i].description!,
                      style: textTheme(context).subtitle2?.apply(
                            color: themeData(context)
                                .backgroundColor
                                .withOpacity(0.4),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CommonCard extends StatelessWidget {
  final Widget child;
  final double? elevation;
  final Color? color;
  const CommonCard({
    Key? key,
    required this.child,
    this.color,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color != null ? color! : null,
      elevation: elevation != null ? elevation! : 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius / 2),
      ),
      child: child,
    );
  }
}
