
class AppInstallationPageArguments {
  final appName;
  final appLogo;
  final appId;
  final bool containsAds;
  final bool iap;
  final installs;
  final rating;
  final whatsNew;
  final dataSafety;
  final shortDescription;
  final longDescription;
  final category;
  final downloadUrl;
  final List<String> imageUrls;

  AppInstallationPageArguments({
    required this.appName,
    required this.appLogo,
    required this.appId,
    required this.containsAds,
    required this.iap,
    required this.installs,
    required this.rating,
    required this.whatsNew,
    required this.dataSafety,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
    required this.downloadUrl,
    required this.imageUrls,
  });
}
