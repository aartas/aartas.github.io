import 'dart:math';
import 'package:aartas_design_system/components/back_button.dart';
import 'package:aartas_design_system/components/glassmorphism.dart';
import 'package:aartas_design_system/const.dart';
import 'package:aartas_design_system/functions/custom_chip.dart';
import 'package:aartas_design_system/models/doctor_model.dart';
import 'package:aartas_design_system/models/speciality_model.dart';
import 'package:aartas_design_system/providers/doctor_provider.dart';
import 'package:aartas_design_system/providers/patient_provider.dart';
import 'package:aartas_design_system/providers/speciality_provider.dart';
import 'package:aartas_website/screens/doctors_details_screen.dart';
import 'package:aartas_website/screens/doctors_screen.dart';
import 'package:aartas_website/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:aartas_design_system/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DocProvider extends ChangeNotifier {
  final List<DoctorData> _doctorList = [];

  List<DoctorData> getList() {
    return _doctorList;
  }

  addToList(List<DoctorData> newDocList) {
    _doctorList.clear();
    _doctorList.addAll(newDocList);
    notifyListeners();
  }
}

openDialog(context, data) {
  showDialog(
    context: context,
    builder: (_) => GlassMorphism(
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor:
            themeData(context).scaffoldBackgroundColor.withOpacity(0.1),
        child: SizedBox(
          width: mediaQuery(context).size.width * 0.98,
          height: mediaQuery(context).size.height * 0.98,
          child: DoctorDetailsScreen(data: data),
        ),
      ),
    ),
  );
}

class AllDoctorsPage extends StatefulWidget {
  final int? selectedSpeciality;
  const AllDoctorsPage({
    this.selectedSpeciality,
    Key? key,
  }) : super(key: key);

  @override
  State<AllDoctorsPage> createState() => _AllDoctorsPageState();
}

class _AllDoctorsPageState extends State<AllDoctorsPage> {
  int? _selectedSpeciality;

  List<Speciality> _speciality = [];

  @override
  void initState() {
    // if (widget.selectedSpeciality != null) {
    // }
    _getSpecialityList();
    super.initState();
  }

  _getSpecialityList() {
    _selectedSpeciality = widget.selectedSpeciality;
    var specialitiesList =
        Provider.of<SpecialityProvider>(context, listen: false).getList();
    if (specialitiesList.isEmpty) {
      var patientID =
          Provider.of<PatientProvider>(context, listen: false).getData().id;
      Provider.of<SpecialityProvider>(context, listen: false)
          .fetchList(baseURL, "$patientID")
          .then((value) {
        _speciality = value.data!.specialityList!;
        setState(() {});
        _updateDoctors();
      });
    } else {
      _speciality = specialitiesList;
      _updateDoctors();
    }
  }

  _updateDoctors() {
    var doctorList =
        Provider.of<DoctorProvider>(context, listen: false).getList();
    List<DoctorData> newdoctorList = [];
    if (_selectedSpeciality != null) {
      for (var a = 0; a < doctorList.length; a++) {
        // print(
        //     "${doctorList[a].speciality!.id} - ${_speciality[_selectedSpeciality!].id}");
        if (doctorList[a].speciality!.id ==
            _speciality[_selectedSpeciality!].id) {
          newdoctorList.add(doctorList[a]);
          // print("${doctorList[a].doctorName}");
        }
      }
      Provider.of<DocProvider>(context, listen: false).addToList(newdoctorList);
    } else {
      Provider.of<DocProvider>(context, listen: false).addToList(doctorList);
    }
  }

  // _updateDoctorList(int? i) {
  //   _selectedSpeciality = i;
  //   _filteredDoctorList.clear();
  //   setState(() {});
  //   if (i == null) {
  //     _filteredDoctorList = _doctors;
  //     setState(() {});
  //   } else {
  //     for (var a = 0; a < _doctors.length; a++) {
  //       if (_doctors[a].speciality!.id == _speciality[i].id) {
  //         _filteredDoctorList.add(_doctors[a]);
  //         setState(() {});
  //       }
  //     }
  //     setState(() {});
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var doctors = Provider.of<DoctorProvider>(context).getList();
    var filteredDoctors = Provider.of<DocProvider>(context).getList();
    // print(
    //     "SELECTED SPECIALITY: $_selectedSpeciality DOC: ${_doctors.length} - ${_filteredDoctors.length}");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: const BButton(),
            // backgroundColor: charcoalColor,
            expandedHeight: mediaQuery(context).size.height + 60,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: charcoalColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                      child: Image(
                        image: AssetImage(
                          "Group.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Container(
                    //   color: themeData(context).backgroundColor,
                    //   height: 60,
                    // )
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                color: themeData(context).colorScheme.background,
                height: 60,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectedSpeciality = null;
                        setState(() {});
                        // var _doctors = Provider.of<DoctorProvider>(
                        //   context,
                        //   listen: false,
                        // ).getList();
                        Provider.of<DocProvider>(context, listen: false)
                            .addToList(doctors);
                      },
                      child: Container(
                        margin:
                            listPadding(_speciality.length, 0, Axis.horizontal),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _selectedSpeciality == null
                              ? textTheme(context).subtitle1!.color
                              : themeData(context).scaffoldBackgroundColor,
                          border: Border.all(
                            color: textTheme(context).subtitle1!.color!,
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All",
                          style: textTheme(context).subtitle1?.apply(
                                fontWeightDelta: 2,
                                color: _selectedSpeciality == null
                                    ? themeData(context).scaffoldBackgroundColor
                                    : null,
                              ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: _speciality.length,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () {
                            List<DoctorData> docs = [];
                            for (var a = 0; a < doctors.length; a++) {
                              if (doctors[a].speciality!.id ==
                                  _speciality[i].id) {
                                docs.add(doctors[a]);
                              }
                            }
                            Provider.of<DocProvider>(context, listen: false)
                                .addToList(docs);
                            setState(() {
                              _selectedSpeciality = i;
                            });
                          },
                          child: Container(
                            margin: listPadding(
                                _speciality.length, i, Axis.horizontal),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _selectedSpeciality == i
                                  ? textTheme(context).subtitle1!.color
                                  : themeData(context).scaffoldBackgroundColor,
                              border: Border.all(
                                color: textTheme(context).subtitle1!.color!,
                              ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${_speciality[i].name}",
                              style: textTheme(context).subtitle1?.apply(
                                    fontWeightDelta: 2,
                                    color: _selectedSpeciality == i
                                        ? themeData(context)
                                            .scaffoldBackgroundColor
                                        : null,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          filteredDoctors.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    height: mediaQuery(context).size.width,
                    alignment: Alignment.center,
                    child: Text(
                      "No Doctors Available for this Speciality.",
                      style: textTheme(context)
                          .subtitle1
                          ?.apply(fontWeightDelta: 2),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      return AllDoctorsThumbnail(
                        doctorsList: filteredDoctors,
                        i: i,
                      );
                    },
                    childCount: filteredDoctors.length,
                  ),
                ),
        ],
      ),
    );
  }
}

class AllDoctorsThumbnail extends StatelessWidget {
  const AllDoctorsThumbnail({
    Key? key,
    required this.doctorsList,
    required this.i,
  }) : super(key: key);

  final List<DoctorData> doctorsList;
  final int i;

  @override
  Widget build(BuildContext context) {
    var grad1 = doctorsList[i].speciality!.bgColor1 != null
        ? doctorsList[i].speciality!.bgColor1.toString().length == 7
            ? "0xFF${doctorsList[i].speciality!.bgColor1!.replaceAll("#", "")}"
            : doctorsList[i].speciality!.bgColor1!.length == 9
                ? "0xFF${doctorsList[i].speciality!.bgColor1!.replaceAll("#", "")}"
                : "0xFF${doctorsList[i].speciality!.bgColor1}"
        : "0xff42a5f5";
    return InkWell(
      onTap: () {
        openDialog(context, doctorsList[i]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        color: themeData(context).backgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomChip(
                    backgroundColor: Color(
                      int.parse(grad1),
                    ),
                    child: Text(
                      "${doctorsList[i].speciality!.name}",
                      style: textTheme(context)
                          .subtitle1
                          ?.apply(color: charcoalColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Dr. ${doctorsList[i].doctorName}",
                    style:
                        textTheme(context).headline6!.apply(fontWeightDelta: 1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${doctorsList[i].degreeSuffix}",
                    style: textTheme(context).subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$rupeeIcon${doctorsList[i].consulationFee} ",
                    style:
                        textTheme(context).subtitle1?.apply(fontWeightDelta: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            DoctorImage(path: doctorsList[i].image!),
          ],
        ),
      ),
    );
  }
}

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    var random = Random().nextInt(999) + 999;
    return Hero(
      transitionOnUserGestures: true,
      tag: "$random$path",
      child: SizedBox(
        width: 176,
        height: 176,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            margin: EdgeInsets.zero,
            // elevation: 4,
            clipBehavior: Clip.hardEdge,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(8),
            // ),
            decoration: BoxDecoration(
              color: themeData(context).backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: 176,
              height: 176,
              imageUrl: "$doctorImageUrl/$path",
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

class SpecializedClinicImage extends StatelessWidget {
  const SpecializedClinicImage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: path,
      child: Container(
        // height: 100,
        // width: 100,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            // width: 320,
            // height: 320,
            imageUrl: "$bundlesImageUrl/$path",
            errorWidget: (context, url, error) => const SizedBox(),
          ),
        ),
      ),
    );
  }
}
