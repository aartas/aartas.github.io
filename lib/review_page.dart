import 'package:aartas_design_system/components/adaptive_widgets/adaptive_button.dart';
import 'package:aartas_design_system/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

List<Rates> rates = [
  Rates(
    title: "Vaishali Vassu",
    rate: 5,
    review:
        "It's a very unique and interesting concept of co-working space for doctors and for patients also.visited there for my consult. Very well spoken and humble staff Delhi's best doctors are there  . Met a girl there Ritiksha she is so kind and helping. Must visit if u need any medical consultation.",
  ),
  Rates(
    title: "ravinder maini",
    rate: 5,
    review:
        "Awesome ambience, thoroughly professional staff. Very knowledgeable doctors. A really wonderful startup by Ankur Sharma. Wish the whole Aartas team best of luck👍",
  ),
  Rates(
    title: "chandresh jain",
    rate: 5,
    review:
        "An cool,  new age,  friendly concept of Clinishare. It's like Co working space from doctors where they can attend their patients in stress free environment at their free will with no corporate hospital type pressure to recommend  certain prescription. The place is completely paperless where appointment,  entry  , prescription and payment all is done via dedicated app. Their is dedicated lounge for doctors and patient separate  to grab a coffee or read a book during wait time.",
  ),
  Rates(
    title: "roshan singh",
    rate: 5,
    review: "Wonderful team and respectful environment",
  ),
  Rates(
    title: "VIVEK KUMAR",
    rate: 5,
    review:
        "It's a totally different kind of combo clinic place with natural ambience and positive vibes 👍👍👍👍👍",
  ),
  Rates(
    title: "Abhishek Jha",
    rate: 5,
    review:
        "Aartas have top notch experts available for most of the diseases and trust me you'll fall in love with the concept, interior, staff and treatment(most important) Will definitely recommend it to my friends n family. Great going n best of luck💟",
  ),
  Rates(
    title: "shweta ralhan",
    rate: 5,
    review:
        "Excellent concept . Very humble and congenial people , best in class facilities . Doctors are able to give good time and attention to every patient . Hope to see Aartas reaching to every zone and city .",
  ),
  Rates(
    title: "Gaurav Rawat",
    rate: 5,
    review:
        "Aartas is a  change in healthcare system..all staff of aartas are too good and so much helpful and kind. India's top doctors are there for helping and treating us .must visit such a good vibe there",
  ),
];

class ReviewsPage extends StatelessWidget {
  final ScrollController controller;
  const ReviewsPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Reviews");
    return Container(
      height: 600,
      padding: const EdgeInsets.only(top: 40),
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
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "See what users are\nsaying about us",
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
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rates.length,
              itemBuilder: (_, i) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    height: 300,
                    width: 280,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Card(
                      color: themeData(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: rates[i].rate!,
                              itemBuilder: (context, index) => const Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 24,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${rates[i].title}".toUpperCase(),
                              style: textTheme(context).titleLarge?.apply(
                                    fontWeightDelta: 2,
                                  ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: Text(
                                "${rates[i].review}",
                                style: textTheme(context).titleMedium,
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
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

class Rates {
  String? title;
  double? rate;
  String? review;

  Rates({
    this.title,
    this.rate,
    this.review,
  });
}
