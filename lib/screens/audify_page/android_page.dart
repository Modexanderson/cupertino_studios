import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class AudifyAndroidPage extends StatelessWidget {
  AudifyAndroidPage({super.key});

  final containsAds = false;
  final iap = false;

  final imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FAudify%20recognition.png?alt=media&token=e022e9cb-dbb3-4011-abd0-4197209b18d0",
  ];

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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: const CupertinoNavigationBar(),
        body: SingleChildScrollView(
          padding: constraints.maxWidth < 900
              ? const EdgeInsets.only(left: 10, right: 10)
              : const EdgeInsets.only(left: 140, right: 140),
          child: Column(
            children: [
              const Text(
                'Audify',
                style: TextStyle(
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
              const Row(
                children: [
                  AppIconWidget(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus.png?alt=media&token=e9186ad5-f6ff-4e0a-b23b-e42bfbc1dc74', // Replace with your app's icon URL
                    size: 100.0, // Specify the size you desire
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        '10+',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Downloads',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        'Rated for 3+',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text('3+'),
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
                      _install(
                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify.apk?alt=media&token=ee237e98-be46-4874-afa6-44b104aa9812'); // Replace with your download logic
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
              const Text(
                'Bug Fixes',
                style: TextStyle(
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
              const Card(
                child: Column(
                  children: [
                    Text(
                      'No data is collected or shared',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
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
                  child: const Text(
                    'High Quality Music Player with lyrics and Audio Recognition!',
                    style: TextStyle(
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
                  child: const Text(
                    ''' 
Supports all music formats such as MP3, MIDI, WAV, FLAC, AAC, APE, etc.

Light weight, simple user interface.

Chameleon view.

Customize sounds with the equalizer settings.

Play songs from a particular album, artist, genre, or playlist.

Adjust song speed to taste.

Sort songs by artist, genre, date added, size, and more.

play background audio.

No annoying ads / no ads at all.

Customize settings to your taste.

Sleep timer.

Control the music player using artwork gestures.

Play songs in shuffle, order, or loop.

Download offline songs from popular sites e.t.c.
                                              ''',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Card(
                child: Text(
                  'Music and Audio',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
