import 'package:flutter/material.dart';

class AppPageArguments {
  final String title;
  final String appLogo;
  final String appImage;
  final String appName;
  final IconData highlightsIcon1;
  final IconData highlightsIcon2;
  final IconData highlightsIcon3;
  final String highlightsTitle1;
  final String highlightsTitle2;
  final String highlightsTitle3;
  final String highlightsDescrition1;
  final String highlightsDescrition2;
  final String highlightsDescrition3;
  final String phoneImage;
  final String privacyPolicyUrl;
  final String shortDescription;
  final String playStoreUrl;
  final String appGalleryUrl;
  final String? appStoreUrl;
  final String featureImage;
  final bool containsAds;
  final bool iap;
  final List<String> imageUrls;
  final androidUrl;
  final iosUrl;
  final linuxUrl;
  final macUrl;
  final windowsUrl;
  final installs;
  final rating;
  final whatsNew;
  final dataSafety;
  final shortIDescription;
  final longDescription;
  final category;

  AppPageArguments({
    required this.title,
    required this.appLogo,
    required this.appImage,
    required this.appName,
    required this.highlightsIcon1,
    required this.highlightsIcon2,
    required this.highlightsIcon3,
    required this.highlightsTitle1,
    required this.highlightsTitle2,
    required this.highlightsTitle3,
    required this.highlightsDescrition1,
    required this.highlightsDescrition2,
    required this.highlightsDescrition3,
    required this.phoneImage,
    required this.privacyPolicyUrl,
    required this.shortDescription,
    required this.playStoreUrl,
    required this.appGalleryUrl,
    this.appStoreUrl,
    required this.featureImage,
    required this.containsAds,
    required this.iap,
    required this.imageUrls,
    required this.androidUrl,
    required this.iosUrl,
    required this.linuxUrl,
    required this.macUrl,
    required this.windowsUrl,
    this.installs,
    this.rating,
    this.whatsNew,
    this.dataSafety,
    this.shortIDescription,
    this.longDescription,
    this.category,
  });
}
