import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/build_feature_row.dart';
import 'package:flutter/cupertino.dart';

class AudifyPage extends StatefulWidget {
  const AudifyPage({super.key});

  @override
  State<AudifyPage> createState() => _AudifyPageState();
}

class _AudifyPageState extends State<AudifyPage> with SingleTickerProviderStateMixin {
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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: Text(
            'Audify',
            style: TextStyle(fontSize: 30, color: Colors.black),
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
                                    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus.png?alt=media&token=e9186ad5-f6ff-4e0a-b23b-e42bfbc1dc74',
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
                                          'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
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
                                      'The High Quality Music Player',
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
                                          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
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
                                        'The High Quality Music Player',
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
                                            imageUrl: 'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
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
                                    context, '/audifymusicplayer/android',
                                    );
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
                    //                 context, '/audifymusicplayer/iOS',
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
                    //                 context, '/audifymusicplayer/linux',
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
                    //                 context, '/audifymusicplayer/macOS',
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
                    //                 context, '/audifymusicplayer/windows',
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
                    const SizedBox(height: 40),
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
                              onPressed: () => _launchURL('https://play.google.com/store/apps/details?id=com.audify.android'),
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
                              onPressed: () => _launchURL('https://appgallery.huawei.com/app/C106997283'),
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
                                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-phone-image.png?alt=media&token=3a793555-6c44-444b-96e0-5ccabd91e24e',
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
                                  buildFeatureRow(
                                    CupertinoIcons.music_note,
                                    'Music Player',
                                    'Listen to your favorite songs on the go.',
                                  ),
                                  const SizedBox(height: 50.0),
                                  buildFeatureRow(
                                    CupertinoIcons.radiowaves_left,
                                    'Audify Recognition',
                                    'Recognize song playing in background.',
                                  ),
                                  const SizedBox(height: 50.0),
                                  buildFeatureRow(
                                    CupertinoIcons.doc_text,
                                    'Lyrics',
                                    'Sing along with song lyrics.',
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
                          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9',
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
}
