import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class AudifyMusicPlayermacOSPage extends StatelessWidget {
  AudifyMusicPlayermacOSPage({super.key});

  final containsAds = false;
  final iap = true;

  final imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
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
                'Audify Music Player',
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
                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify.png?alt=media&token=ae77d914-55e2-4f3d-a129-280777621d93', // Replace with your app's icon URL
                    size: 100.0, // Specify the size you desire
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        '1k+',
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
                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify-music-player.apk?alt=media&token=ce7a31ab-0e34-4309-be6e-7cddc1f636fa'); // Replace with your download logic
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
                    'High Quality Music Player with lyrics!',
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

Ads free.

Chameleon view.

Customize sounds with the equalizer settings.

Play songs from a particular album, artist, genre, or playlist.

Adjust your song speed and listen to it play in fast mode or lesser speed interval.

Sort songs by artist, genre, date added, size: You can choose how you want your songs to be sorted in the library according to the listed options.

Play background audio: Music continues playing even when you close the app unless you customize otherwise.

Customize settings to your taste: Audify comes with a lot of features which you can customize in settings.

Sleep timer: Set the time at which you want your songs to stop playing or the number of songs you want to play, as soon as this parameter is reached your the music player stops.

Control the music player using artwork gestures: You can control the music player functions using the artwork gesture or mini player by swiping and it skips to next song and more.

Play songs in shuffle, order, or loop: You have the ability to play your songs in whatever mode you want e.g shuffle mode plays songs in random order and more..

Download offline songs from popular sites: music download sites is included in the menu of the music player where you can download songs and listen to.
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
