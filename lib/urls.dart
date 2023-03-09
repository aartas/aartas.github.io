// UAT TESTING URL

import 'package:flutter/material.dart';

String uatURL =
    "https://aartas-qaapp-as.azurewebsites.net/aartas_uat/public/api";
// LIVE PRODUCTION URL
String liveURL = "https://aartas.com/v1/public/api";

//? BASE URL
String baseURL = uatURL;

// -------------------

String documentImageURL = "$baseURL/../assets/scanned_documents";
String labelImageURL = "$baseURL/../assets/vaccine_labels";
String iconImageUrl = "$baseURL/../assets/icons";
String doctorImageUrl = "$baseURL/../assets/doctor";
String homeFeedImageUrl = "$baseURL/../assets/home_feed";
String onBoardingImageUrl = "$baseURL/../assets/onboarding";
String bundlesImageUrl = "$baseURL/../assets/bundles";
String membershipImageUrl = "$baseURL/../assets/membership";
String journeyImageUrl = "$baseURL/../assets/journey_images";
String clinicRoomImageUrl = "$baseURL/../assets/clinic_rooms";
String customNotificationImageUrl =
    "$baseURL/../assets/custom_notification_images";
String customImageUrl = "$baseURL/../assets/custom_images";

// -------------------

BoxConstraints websiteWidth(context) {
  return const BoxConstraints(
    maxWidth: 1200,
    minWidth: 300,
  );
}
