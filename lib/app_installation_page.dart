import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'horizontal_scrolling_list.dart';

class AppInstallationPage extends StatelessWidget {
  final appName;
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

  AppInstallationPage(
      {required this.appName,
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
      super.key});

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
    return Scaffold(
      appBar: const CupertinoNavigationBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              appName,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Cupertino Studios',
              style: TextStyle(fontSize: 30, fontFamily: 'SF Arch Rival Bold'),
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
                Column(
                  children: [
                    Text(
                      installs,
                      style: const TextStyle(
                          fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                    ),
                    const Text(
                      'Downloads',
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Rated',
                      style: TextStyle(
                          fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                    ),
                    Text(rating),
                  ],
                )
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
                    primary: Colors.blue, // Customize button color
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
                      fontFamily: 'SF Arch Rival Bold',
                      color: Colors.white, // Customize button text color
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                const Text(
                  'Share',
                  style:
                      TextStyle(fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'This app is available for some of your devices',
              style: TextStyle(fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            HorizontalScrollingList(
              itemCount: imageUrls.length,
              imageUrl: imageUrls,
            ),
            // Row(
            //   children: [
            //     Image.network(''),
            //     Image.network(''),
            //     Image.network(''),
            //     Image.network(''),
            //     Image.network(''),
            //     Image.network(''),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'What,s new',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Arch Rival Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              whatsNew,
              style: const TextStyle(
                  fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Data Safety',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Arch Rival Bold'),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Column(children: [
                Text(
                  dataSafety,
                  style: const TextStyle(
                      fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
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
                fontFamily: 'SF Arch Rival Bold',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Text(
                shortDescription,
                style: const TextStyle(
                    fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Text(
                longDescription,
                style: const TextStyle(
                    fontSize: 20, fontFamily: 'SF Arch Rival Bold'),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Card(
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'SF Arch Rival Bold',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
