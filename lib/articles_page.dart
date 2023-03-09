import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/const.dart';
import 'package:aartas_website/designed_for_you_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

List<Articles> articles = [
  Articles(
    title:
        "Aartas CliniShare is an unique Concept, that will disrupt the Indian healthcare industry.",
    discription:
        "Keynote by Shri. Amitabh Kant, CEO, Niti Ayog on the inauguration of flagship Aartas CliniShare at Ring Road, Lajpat Nagar, New Delhi.",
    image: "Image1.jpg",
    url: "https://www.youtube.com/watch?v=QDA7pO4-G4M",
  ),
  Articles(
    title: "Aartas CliniShare is reinventing the Doctors private clinic.",
    discription:
        "The medical co-working startup plans to create a system where doctors practice their idea of care that works best for their patients.",
    image: "Image2.jpg",
    url:
        "https://yourstory.com/2021/08/delhi-based-medical-coworking-startup-aartas-clinishare-doctors",
  ),
  Articles(
    title: "Aartas creates a parallel healthcare Eco-system.",
    discription:
        "CliniShare is modeled on the principal of shared economy helping reduce the burden on existing Healthcare system.",
    image: "Image3.jpg",
    url:
        "https://www.businesstoday.in/technology/news/story/aartas-creates-parallel-healthcare-ecosystem-helps-doctors-practice-at-paperless-co-working-clinic-space-306978-2021-09-17",
  ),
  Articles(
    title: "Omicron variant puts spotlight back on safety.",
    discription:
        "Expert Dr. Vidya Taneja, pediatrician gives her view on the new variant of coronavirus COVID-19.",
    image: "Image4.jpg",
    url:
        "https://www.thehindu.com/news/national/coronavirus-omicron-variant-puts-spotlight-back-on-safety/article37741890.ece",
  ),
];

class ArticlesPage extends StatelessWidget {
  final ScrollController controller;
  const ArticlesPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Articles");
    return Container(
      height: 600,
      width: mediaQuery(context).size.width,
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
      margin: const EdgeInsets.only(top: 56),
      padding: const EdgeInsets.only(top: 56),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "The best healthcare comes${mediaQuery(context).size.width > 700 ? "\n" : " "}without any compromise.",
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
          Container(
            constraints: const BoxConstraints(minHeight: 200, maxHeight: 400),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (_, i) {
                return InkWell(
                  onTap: () {
                    openUrls("${articles[i].url}");
                  },
                  child: Container(
                    height: 300,
                    width: 300,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: themeData(context).scaffoldBackgroundColor,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage("${articles[i].image}"),
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "${articles[i].title}",
                                style: textTheme(context).titleLarge?.apply(
                                      fontWeightDelta: 2,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 4, 16, 16),
                                child: Text(
                                  "${articles[i].discription}",
                                  style: textTheme(context).titleMedium,
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Articles {
  String? title;
  String? discription;
  String? image;
  String? url;

  Articles({
    this.title,
    this.discription,
    this.image,
    this.url,
  });
}
