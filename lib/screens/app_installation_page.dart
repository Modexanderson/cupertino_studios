import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_icon_widget.dart';
import '../models/app_installation_page_arguments.dart';
import '../widgets/horizontal_scrolling_list.dart';

class AppInstallationPage extends StatelessWidget {
  AppInstallationPage({super.key});

  // void _launchDownloadLink() {
  //   // Replace the URL with your GitHub APK file URL
  //   final url = downloadUrl;
  //   // Use JavaScript to trigger the download
  //   final anchor = AnchorElement(href: url)
  //     ..target = 'blank'
  //     ..click();
  // }
  // final storageUrl =
  //     "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fapp-release.apk?alt=media&token=486c9314-0308-40fa-981d-7f38b4d4843e";
  void _install(String url) {
    // Use JavaScript to trigger the download
    final jsCode = '''
      const link = document.createElement('a');
      link.href = '$url';
      link.download = 'your-apk-filename.apk'; // Replace with the desired filename
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    ''';

    // Execute the JavaScript code
    context.callMethod('eval', [jsCode]);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as AppInstallationPageArguments;
    final appName = args.appName;
    final appLogo = args.appLogo;
    final appId = args.appId;
    final bool containsAds = args.containsAds;
    final bool iap = args.iap;
    final installs = args.installs;
    final rating = args.rating;
    final whatsNew = args.whatsNew;
    final dataSafety = args.dataSafety;
    final shortDescription = args.shortDescription;
    final longDescription = args.longDescription;
    final category = args.category;
    final downloadUrl = args.downloadUrl;
    final List<String> imageUrls = args.imageUrls;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const CupertinoNavigationBar(),
          body: SingleChildScrollView(
            padding: constraints.maxWidth < 900
                    ? const EdgeInsets.only(left: 10, right: 10)
                    : const EdgeInsets.only(left: 140, right: 140),
            child: Column(
              children: [
                Text(
                  appName,
                  style: const TextStyle(
                    fontSize: 60,
                    fontFamily: 'ALVA',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Cupertino Studios',
                  style: TextStyle(
                    fontSize: 13,
                    // fontFamily: 'SF Arch Rival Bold',
                  ),
                ),
                const SizedBox(),
                Row(
                  children: [
                    if (containsAds)
                      const Text(
                        'Contains Ads',
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                      ),
                    if (iap)
                      const Text(
                        'In-app purchases',
                        style: TextStyle(
                            fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    AppIconWidget(
                      imageUrl: appLogo, // Replace with your app's icon URL
                      size: 100.0, // Specify the size you desire
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          installs,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Downloads',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          'Rated for $rating',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(rating),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _install(downloadUrl); // Replace with your download logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Customize button color
                        minimumSize: const Size(200, 48), // Increase button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Customize button border radius
                        ),
                      ),
                      child: const Text(
                        'Install',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Customize button text color
                        ),
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'This app is available for all your devices',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                HorizontalScrollingList(
                  itemCount: imageUrls.length,
                  imageUrl: imageUrls,
                ),
               
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "What's new",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  whatsNew,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Data Safety',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(children: [
                    Text(
                      dataSafety,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'About this app',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      shortDescription,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      longDescription,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Text(
                    category,
                    style:
                        const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
