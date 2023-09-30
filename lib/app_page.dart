import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_installation_page_arguments.dart';
import 'app_page_argument.dart';

class AppPage extends StatefulWidget {
  // final String title;
  // final String appLogo;
  // final String appImage;
  // final String appName;
  // final IconData highlightsIcon1;
  // final IconData highlightsIcon2;
  // final IconData highlightsIcon3;
  // final String highlightsTitle1;
  // final String highlightsTitle2;
  // final String highlightsTitle3;
  // final String highlightsDescrition1;
  // final String highlightsDescrition2;
  // final String highlightsDescrition3;
  // final String phoneImage;
  // final String privacyPolicyUrl;
  // final String shortDescription;
  // final String playStoreUrl;
  // final String appGalleryUrl;
  // final String? appStoreUrl;
  // final String featureImage;
  // final bool containsAds;
  // final bool iap;
  // final List<String> imageUrls;
  // final androidUrl;
  // final iosUrl;
  // final linuxUrl;
  // final macUrl;
  // final windowsUrl;
  // final installs;
  // final rating;
  // final whatsNew;
  // final dataSafety;
  // final shortIDescription;
  // final longDescription;
  // final category;
  const AppPage({
    // required this.title,
    // required this.appLogo,
    // required this.appImage,
    // required this.appName,
    // required this.highlightsIcon1,
    // required this.highlightsIcon2,
    // required this.highlightsIcon3,
    // required this.highlightsTitle1,
    // required this.highlightsTitle2,
    // required this.highlightsTitle3,
    // required this.highlightsDescrition1,
    // required this.highlightsDescrition2,
    // required this.highlightsDescrition3,
    // required this.phoneImage,
    // required this.privacyPolicyUrl,
    // required this.shortDescription,
    // required this.playStoreUrl,
    // required this.appGalleryUrl,
    // this.appStoreUrl,
    // required this.featureImage,
    // required this.containsAds,
    // required this.iap,
    // required this.imageUrls,
    // required this.androidUrl,
    // required this.iosUrl,
    // required this.linuxUrl,
    // required this.macUrl,
    // required this.windowsUrl,
    // this.installs,
    // this.rating,
    // this.whatsNew,
    // this.dataSafety,
    // this.shortIDescription,
    // this.longDescription,
    // this.category,
    super.key,
  });

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Animation<double>? _fadeAnimation;

  Animation<double>? _sizeAnimation;

  ////////////////
  // AnimationController? _textAnimationController;
  Animation<Offset>? _textSlideAnimation;

  // AnimationController? _imageAnimationController;
  Animation<Offset>? _imageSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as AppPageArguments;
    final title = args.title;
    final appLogo = args.appLogo;
    final appImage = args.appImage;
    final appName = args.appName;
    final highlightsIcon1 = args.highlightsIcon1;
    final highlightsIcon2 = args.highlightsIcon2;
    final highlightsIcon3 = args.highlightsIcon3;
    final highlightsTitle1 = args.highlightsTitle1;
    final highlightsTitle2 = args.highlightsTitle2;
    final highlightsTitle3 = args.highlightsTitle3;
    final highlightsDescrition1 = args.highlightsDescrition1;
    final highlightsDescrition2 = args.highlightsDescrition2;
    final highlightsDescrition3 = args.highlightsDescrition3;
    final phoneImage = args.phoneImage;
    final privacyPolicyUrl = args.privacyPolicyUrl;
    final shortDescription = args.shortDescription;
    final playStoreUrl = args.playStoreUrl;
    final appGalleryUrl = args.appGalleryUrl;
    final appStoreUrl = args.appStoreUrl;
    final featureImage = args.featureImage;
    final containsAds = args.containsAds;
    final iap = args.iap;
    final imageUrls = args.imageUrls;
    final androidUrl = args.androidUrl;
    final iosUrl = args.iosUrl;
    final linuxUrl = args.linuxUrl;
    final macUrl = args.macUrl;
    final windowsUrl = args.windowsUrl;
    final installs = args.installs;
    final rating = args.rating;
    final whatsNew = args.whatsNew;
    final dataSafety = args.dataSafety;
    final shortIDescription = args.shortDescription;
    final longDescription = args.longDescription;
    final category = args.category;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text(
            title,
            style: const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: constraints.maxWidth < 900
                    ? const EdgeInsets.only(left: 10, right: 10)
                    : const EdgeInsets.only(left: 140, right: 140),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        AnimatedBuilder(
                          animation: _animationController!,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeAnimation!.value,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: _sizeAnimation!.value * 70,
                                height: _sizeAnimation!.value * 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: appLogo,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),

                                    width: 150.0, // Set the width of each image
                                    height:
                                        150.0, // Set the height of each image
                                    fit: BoxFit.cover, // Adjust the image's fit
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                    child: const Text('Home')),
                                // TextButton(
                                //     onPressed: () {}, child: const Text('FAQ')),
                                // TextButton(
                                //     onPressed: () {
                                //       launchUrl(
                                //         Uri.parse(
                                //           'https://twitter.com/StudioCupertino',
                                //         ),
                                //       );
                                //     },
                                //     child: const Text('Blog')),
                                TextButton(
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse(
                                          privacyPolicyUrl,
                                        ),
                                      );
                                    },
                                    child: const Text('Privacy Policy')),
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: constraints.maxWidth < 900
                            ? const EdgeInsets.all(10.0)
                            : const EdgeInsets.all(4.0),
                        child: constraints.maxWidth < 900
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SlideTransition(
                                    position: _textSlideAnimation!,
                                    child: Text(
                                      shortDescription,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: SlideTransition(
                                      position: _imageSlideAnimation!,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: appImage,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: double.infinity,
                                          height: 660,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: SlideTransition(
                                      position: _textSlideAnimation!,
                                      child: Text(
                                        shortDescription,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      child: SlideTransition(
                                        position: _imageSlideAnimation!,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: appImage,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            width: double.infinity,
                                            height: 660,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      'Install Now!',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 100),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/appInstallationPage',
                                    arguments: AppInstallationPageArguments(
                                      appName: appName,
                                      appLogo: appLogo,
                                      appId: 'com.$appName.android',
                                      containsAds: containsAds,
                                      iap: iap,
                                      installs: installs,
                                      rating: rating,
                                      whatsNew: whatsNew,
                                      dataSafety: dataSafety,
                                      shortDescription: shortDescription,
                                      longDescription: longDescription,
                                      category: category,
                                      downloadUrl: androidUrl,
                                      imageUrls: imageUrls,
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      width: 100,
                                      imageUrl:
                                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/android.png?alt=media&token=53a4be3c-8ea0-4187-a49a-a8587b8bdc9f',
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit
                                          .cover, // Adjust the image's fit
                                    ),
                                  ),
                                  const Text(
                                    'Android',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'SF Arch Rival Bold'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 40),
                    // Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         CupertinoButton(
                    //           onPressed: () {
                    //             Navigator.pushNamed(
                    //                 context, '/appInstallationPage',
                    //                 arguments: AppInstallationPageArguments(
                    //                   appName: appName,
                    //                   appLogo: appLogo,
                    //                   appId: 'com.$appName.iOS',
                    //                   containsAds: containsAds,
                    //                   iap: iap,
                    //                   installs: installs,
                    //                   rating: rating,
                    //                   whatsNew: whatsNew,
                    //                   dataSafety: dataSafety,
                    //                   shortDescription: shortDescription,
                    //                   longDescription: longDescription,
                    //                   category: category,
                    //                   downloadUrl: iosUrl,
                    //                   imageUrls: imageUrls,
                    //                 ));
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8.0),
                    //                 child: CachedNetworkImage(
                    //                   width: 100,
                    //                   imageUrl:
                    //                       'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/apple.png?alt=media&token=5fe90103-f05c-4fab-8991-8c5f9c1a082d',
                    //                   placeholder: (context, url) =>
                    //                       const Center(
                    //                           child:
                    //                               CircularProgressIndicator()),
                    //                   errorWidget: (context, url, error) =>
                    //                       const Icon(Icons.error),
                    //                   fit: BoxFit
                    //                       .cover, // Adjust the image's fit
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 'iPhone OS',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontFamily: 'SF Arch Rival Bold'),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 40),
                    // Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         CupertinoButton(
                    //           onPressed: () {
                    //             Navigator.pushNamed(
                    //                 context, '/appInstallationPage',
                    //                 arguments: AppInstallationPageArguments(
                    //                   appName: appName,
                    //                   appLogo: appLogo,
                    //                   appId: 'com.$appName.linux',
                    //                   containsAds: containsAds,
                    //                   iap: iap,
                    //                   installs: installs,
                    //                   rating: rating,
                    //                   whatsNew: whatsNew,
                    //                   dataSafety: dataSafety,
                    //                   shortDescription: shortDescription,
                    //                   longDescription: longDescription,
                    //                   category: category,
                    //                   downloadUrl: linuxUrl,
                    //                   imageUrls: imageUrls,
                    //                 ));
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8.0),
                    //                 child: CachedNetworkImage(
                    //                   width: 100,
                    //                   imageUrl:
                    //                       'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/linux.png?alt=media&token=5d05044f-a263-48e0-8165-38fa9123593a',
                    //                   placeholder: (context, url) =>
                    //                       const Center(
                    //                           child:
                    //                               CircularProgressIndicator()),
                    //                   errorWidget: (context, url, error) =>
                    //                       const Icon(Icons.error),
                    //                   fit: BoxFit
                    //                       .cover, // Adjust the image's fit
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 'Linux OS',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontFamily: 'SF Arch Rival Bold'),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 40),
                    // Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         CupertinoButton(
                    //           onPressed: () {
                    //             Navigator.pushNamed(
                    //                 context, '/appInstallationPage',
                    //                 arguments: AppInstallationPageArguments(
                    //                   appName: appName,
                    //                   appLogo: appLogo,
                    //                   appId: 'com.$appName.macOS',
                    //                   containsAds: containsAds,
                    //                   iap: iap,
                    //                   installs: installs,
                    //                   rating: rating,
                    //                   whatsNew: whatsNew,
                    //                   dataSafety: dataSafety,
                    //                   shortDescription: shortDescription,
                    //                   longDescription: longDescription,
                    //                   category: category,
                    //                   downloadUrl: macUrl,
                    //                   imageUrls: imageUrls,
                    //                 ));
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8.0),
                    //                 child: CachedNetworkImage(
                    //                   width: 100,
                    //                   imageUrl:
                    //                       'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/macOS.png?alt=media&token=10672558-6062-41a5-bc51-83d348c42e83',
                    //                   placeholder: (context, url) =>
                    //                       const Center(
                    //                           child:
                    //                               CircularProgressIndicator()),
                    //                   errorWidget: (context, url, error) =>
                    //                       const Icon(Icons.error),
                    //                   fit: BoxFit
                    //                       .cover, // Adjust the image's fit
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 'macOS',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontFamily: 'SF Arch Rival Bold'),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 40),
                    // Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         CupertinoButton(
                    //           onPressed: () {
                    //             Navigator.pushNamed(
                    //                 context, '/appInstallationPage',
                    //                 arguments: AppInstallationPageArguments(
                    //                   appName: appName,
                    //                   appLogo: appLogo,
                    //                   appId: 'com.$appName.windows',
                    //                   containsAds: containsAds,
                    //                   iap: iap,
                    //                   installs: installs,
                    //                   rating: rating,
                    //                   whatsNew: whatsNew,
                    //                   dataSafety: dataSafety,
                    //                   shortDescription: shortDescription,
                    //                   longDescription: longDescription,
                    //                   category: category,
                    //                   downloadUrl: windowsUrl,
                    //                   imageUrls: imageUrls,
                    //                 ));
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius: BorderRadius.circular(8.0),
                    //                 child: CachedNetworkImage(
                    //                   width: 100,
                    //                   imageUrl:
                    //                       'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/windows.png?alt=media&token=68325716-9094-4bfc-b121-67b336ab1460',
                    //                   placeholder: (context, url) =>
                    //                       const Center(
                    //                           child:
                    //                               CircularProgressIndicator()),
                    //                   errorWidget: (context, url, error) =>
                    //                       const Icon(Icons.error),
                    //                   fit: BoxFit
                    //                       .cover, // Adjust the image's fit
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 'Windows OS',
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontFamily: 'SF Arch Rival Bold'),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
                    const Text(
                      'iOS VERSION IN DEVELOPMENT',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Stores Listed!',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 100),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              onPressed: () => _launchURL(playStoreUrl),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      width: 100,
                                      imageUrl:
                                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/play_store.png?alt=media&token=a44e3ad9-2b2c-455e-bcae-229f8fbf60a7',
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit
                                          .cover, // Adjust the image's fit
                                    ),
                                  ),
                                  const Text(
                                    'Google Play Store',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'SF Arch Rival Bold'),
                                  )
                                ],
                              ),
                            ),
                            // const SizedBox(width: 16),
                            // CupertinoButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //       context,
                            //       '/iosinstallation',
                            //       arguments: {
                            //         'appName': appName,
                            //         'appIcon': appLogo,
                            //         'appDownloadUrl': appDownloadUrl,
                            //       },
                            //     );
                            //   },
                            //   // onPressed: () => _launchURL(appStoreUrl),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //     child: Image.asset(
                            //       'images/app_store.png',
                            //       width: 100,
                            //       // height: 40,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              onPressed: () => _launchURL(appGalleryUrl),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      width: 100,
                                      imageUrl:
                                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/huawei-appgallery.png?alt=media&token=5a1ca6e0-cff6-4a49-9cbd-2edc20a06aab',
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit
                                          .cover, // Adjust the image's fit
                                    ),
                                  ),
                                  const Text(
                                    'Huawei AppGallery',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'SF Arch Rival Bold'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'iOS VERSION IN DEVELOPMENT',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      'Highlights',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 100),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: phoneImage,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),

                                  // width:
                                  //     MediaQuery.of(context).size.width * 0.6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 50.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 100.0),
                                  _buildFeatureRow(
                                    highlightsIcon1,
                                    highlightsTitle1,
                                    highlightsDescrition1,
                                  ),
                                  const SizedBox(height: 50.0),
                                  _buildFeatureRow(
                                    highlightsIcon2,
                                    highlightsTitle2,
                                    highlightsDescrition2,
                                  ),
                                  const SizedBox(height: 50.0),
                                  _buildFeatureRow(
                                    highlightsIcon3,
                                    highlightsTitle3,
                                    highlightsDescrition3,
                                  ),
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
              const SizedBox(height: 100),
              Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Text(
                      'Sleek Interface',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle
                          .copyWith(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 100.0),
                    Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: featureImage,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          // Set the width of each image
                          width: MediaQuery.of(context).size.width,
                          // Set the height of each image
                          fit: BoxFit.cover, // Adjust the image's fit
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFeatureRow(IconData iconData, String title, String description) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Icon(iconData, size: 25, color: Colors.black),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth > 900 ? 20 : 16,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
