import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_page_argument.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'cupertinostudios@gmail.com',
      queryParameters: {
        'body': 'Hello, ',
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.black, BlendMode.srcIn),
                      child: Image.asset(
                        'icons/logo-no-background.png',
                        width: MediaQuery.of(context).size.width * 0.09,
                        // height: 100,

                        fit: BoxFit.contain,
                        // alignment: Alignment.topCenter,
                      ),
                    ),
                    constraints.maxWidth < 900
                        ? const Expanded(
                            child: Text(
                              'Welcome to Cupertino Studios',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 123.0),
                              child: Text(
                                'Welcome to Cupertino Studios',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                  ],
                ),
                const SizedBox(height: 20),
                const Card(
                  child: Text(
                    'We build beautiful and powerful mobile apps.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/home-screen-image.jpg?alt=media&token=bdf46aa0-6c06-4ac9-8cb3-ce5f67dc0413',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover, // Adjust the image's fit
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                // width: 800,
                                child: Text(
                                  '"High-quality mobile apps are more than just lines of code. They are seamless experiences, crafted with precision and care, that delight users and solve their everyday challenges."',
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 700 ? 16 : 25,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Contact Us'),
                  onPressed: () {
                    sendEmail();
                  },
                ),
                const SizedBox(height: 20),
                Card(
                  child: Text(
                    'Our Apps',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                constraints.maxWidth < 900
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppCard(
                            appName: 'Audify',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(context, '/appPage',
                                  arguments: AppPageArguments(
                                    title: 'Audify',
                                    appLogo:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus.png?alt=media&token=e9186ad5-f6ff-4e0a-b23b-e42bfbc1dc74',
                                    appImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
                                    appName: 'Audify',
                                    highlightsIcon1: CupertinoIcons.music_note,
                                    highlightsIcon2:
                                        CupertinoIcons.radiowaves_left,
                                    highlightsIcon3: CupertinoIcons.doc_text,
                                    highlightsTitle1: 'Music Player',
                                    highlightsTitle2: 'Audify Recognition',
                                    highlightsTitle3: 'Lyrics',
                                    highlightsDescrition1:
                                        'Listen to your favorite songs on the go.',
                                    highlightsDescrition2:
                                        'Recognize song playing in background.',
                                    highlightsDescrition3:
                                        'Sing along with song lyrics.',
                                    phoneImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-phone-image.png?alt=media&token=3a793555-6c44-444b-96e0-5ccabd91e24e',
                                    privacyPolicyUrl:
                                        'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
                                    shortDescription:
                                        'The high quality Music Player',
                                    playStoreUrl:
                                        "https://play.google.com/store/apps/details?id=com.audify.android",
                                    appGalleryUrl:
                                        "https://appgallery.huawei.com/app/C106997283",
                                    featureImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9',
                                    androidUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify.apk?alt=media&token=ee237e98-be46-4874-afa6-44b104aa9812',
                                    iosUrl: '',
                                    linuxUrl: '',
                                    macUrl: '',
                                    windowsUrl: '',
                                    containsAds: false,
                                    iap: false,
                                    imageUrls: [
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FAudify%20recognition.png?alt=media&token=e022e9cb-dbb3-4011-abd0-4197209b18d0",
                                    ],
                                    installs: '10+',
                                    rating: '3+',
                                    whatsNew: 'Bug Fixes',
                                    dataSafety:
                                        'No data is collected or shared',
                                    shortIDescription:
                                        'High Quality Music Player with lyrics and Audio Recognition!',
                                    longDescription: ''' 
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
                                    category: 'Music and Audio',
                                  ));
                            },
                          ),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                  title: 'Audify Music Player',
                                  appLogo:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify.png?alt=media&token=ae77d914-55e2-4f3d-a129-280777621d93',
                                  shortDescription:
                                      'The high quality Music Player',
                                  appImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
                                  appName: 'Audify Music Player',
                                  playStoreUrl:
                                      "https://play.google.com/store/apps/details?id=com.music.audify",
                                  appGalleryUrl:
                                      "https://appgallery.huawei.com/app/C108258673",
                                  appStoreUrl:
                                      "https://www.apple.com/app-store/",
                                  phoneImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-phone-image.png?alt=media&token=3a793555-6c44-444b-96e0-5ccabd91e24e',
                                  privacyPolicyUrl:
                                      'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
                                  highlightsIcon1: CupertinoIcons.music_note_2,
                                  highlightsTitle1: 'Music Player',
                                  highlightsDescrition1:
                                      'Listen to your favorite songs on the go.',
                                  highlightsIcon2: CupertinoIcons.wrench,
                                  highlightsTitle2: 'Theme Customization',
                                  highlightsDescrition2:
                                      'Customize theme to your taste.',
                                  highlightsIcon3: CupertinoIcons.doc_text,
                                  highlightsTitle3: 'Lyrics',
                                  highlightsDescrition3:
                                      'Sing along with song lyrics.',
                                  featureImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify-feature.png?alt=media&token=e8a6501c-02c3-49f9-b5f2-02c2e98fe545',
                                  androidUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify-music-player.apk?alt=media&token=ce7a31ab-0e34-4309-be6e-7cddc1f636fa',
                                  iosUrl: '',
                                  linuxUrl: '',
                                  macUrl: '',
                                  windowsUrl: '',
                                  containsAds: false,
                                  iap: true,
                                  imageUrls: [
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
                                  ],
                                  installs: '1k+',
                                  rating: '3+',
                                  whatsNew: 'Bug Fixes',
                                  dataSafety: 'No data is collected or shared',
                                  shortIDescription:
                                      'High Quality Music Player with lyrics!',
                                  longDescription: ''' 
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
                                  category: 'Music and Audio',
                                ),
                              );
                            },
                          ),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                    title: 'GPA Calculator',
                                    appLogo:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator.png?alt=media&token=430c34d6-f8f6-48af-b423-e1ccb72729e8',
                                    shortDescription:
                                        'The high qualityGrade Calculator',
                                    appImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpacalculator-grades.png?alt=media&token=bcad79f4-a962-4fe2-87a6-ad48d9367e52',
                                    appName: 'GPA Calculator',
                                    playStoreUrl:
                                        "https://play.google.com/store/apps/details?id=com.anderson.gpa_calculator",
                                    appGalleryUrl:
                                        "https://appgallery.huawei.com/app/C106977151",
                                    appStoreUrl:
                                        "https://www.apple.com/app-store/",
                                    phoneImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943',
                                    privacyPolicyUrl:
                                        'https://www.privacypolicies.com/live/919bba91-173c-4699-8191-c0781afc0ee9',
                                    highlightsIcon1:
                                        CupertinoIcons.graph_circle,
                                    highlightsTitle1: 'Real Time Grading',
                                    highlightsDescrition1:
                                        'Calculate your grades on the go.',
                                    highlightsIcon2: CupertinoIcons.headphones,
                                    highlightsTitle2: 'Get Support',
                                    highlightsDescrition2:
                                        'Get Support from Admin.',
                                    highlightsIcon3:
                                        CupertinoIcons.conversation_bubble,
                                    highlightsTitle3: 'Request Features',
                                    highlightsDescrition3:
                                        'Request more features.',
                                    featureImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943',
                                    androidUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpacalculator.apk?alt=media&token=6a1df79e-6114-4e6a-bfab-e9a22baa4555',
                                    iosUrl: '',
                                    linuxUrl: '',
                                    macUrl: '',
                                    windowsUrl: '',
                                    containsAds: true,
                                    iap: false,
                                    imageUrls: [
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fscreenshots%2Fgpacalculator-phone-image.png?alt=media&token=b0b11b0f-1dc8-42e1-bdad-32fb7d8be97b",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fscreenshots%2Fgpacalculator-support.png?alt=media&token=98e7cd8a-034b-4175-864c-9fa793f35d48",
                                    ],
                                    installs: '100+',
                                    rating: '3+',
                                    whatsNew: 'Bug Fixes',
                                    dataSafety:
                                        'No data is collected or shared',
                                    shortIDescription:
                                        'High Quality Music Player with lyrics and Audio Recognition!',
                                    longDescription: ''' 
GPA Calculator is a mobile application that helps students in the 
University, colleges and other institution to calculate their grade 
point average managing all the formula complexity for students using 
the Nigeria and other country's grading system.
                                        ''',
                                    category: 'Tools'),
                              );
                            },
                          ),
                          AppCard(
                            appName: 'Imagen',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                  title: 'Imagen',
                                  appLogo:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen_black.png?alt=media&token=85def552-0002-40a9-b917-274cc0b704d5',
                                  shortDescription:
                                      'The Powerful AI Image Generator',
                                  appImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCamp%20Family.png?alt=media&token=aba6b809-baff-4a98-af5b-36b52c1e928d',
                                  appName: 'Imagen',
                                  playStoreUrl: "",
                                  appGalleryUrl:
                                      "https://appgallery.huawei.com/app/C109151501",
                                  appStoreUrl: "",
                                  phoneImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FEmotion%20or%20Mood-Based%20Prompts.png?alt=media&token=6f8bf915-59ed-4326-b8d4-62765233a1a0',
                                  privacyPolicyUrl:
                                      'https://www.privacypolicies.com/live/919bba91-173c-4699-8191-c0781afc0ee9',
                                  highlightsIcon1: CupertinoIcons.graph_circle,
                                  highlightsTitle1:
                                      'Real Time Image Generation',
                                  highlightsDescrition1:
                                      'Generate Powerful Images with Few prompts',
                                  highlightsIcon2: CupertinoIcons.paintbrush,
                                  highlightsTitle2: 'Customize Style',
                                  highlightsDescrition2:
                                      'Customize Image with preset styles.',
                                  highlightsIcon3: CupertinoIcons.resize,
                                  highlightsTitle3: 'Choose Image Resolution',
                                  highlightsDescrition3:
                                      'Select your desired Image Resolution.',
                                  featureImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5',
                                  androidUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen.apk?alt=media&token=ae262dbf-72fc-4796-93e0-cb64cc87a38f',
                                  iosUrl: '',
                                  linuxUrl: '',
                                  macUrl: '',
                                  windowsUrl: '',
                                  containsAds: false,
                                  iap: false,
                                  imageUrls: [
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FA%20close-up%20view%20of%20petal%20image.png?alt=media&token=7655da56-63a5-4d99-b78c-9423873582a8",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FArtwork%20Image%20Description.png?alt=media&token=ece0a75f-4e38-4554-8ab2-de6c83a7fab1",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCamp%20Family.png?alt=media&token=aba6b809-baff-4a98-af5b-36b52c1e928d",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCyberpunk%20Urban%20Setting.png?alt=media&token=3d9b7031-7f19-43df-b794-a1ea0ba86eb5",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FEmotion%20or%20Mood-Based%20Prompts.png?alt=media&token=6f8bf915-59ed-4326-b8d4-62765233a1a0",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FExperience%20Magical%20Image%20Generarion.png?alt=media&token=0d158b54-4572-4a65-92be-bcbf2f7de35c",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FHistorical%20or%20Cultural%20References%20(1).png?alt=media&token=d611818e-f84e-42c1-a962-24b968a11625",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FReference%20Image%20Using%20Artist%20Name.png?alt=media&token=20e4531c-0fe6-4da2-94c7-893e353b6442",
                                  ],
                                  installs: '100+',
                                  rating: '3+',
                                  whatsNew: 'Bug Fixes',
                                  dataSafety: 'No data is collected or shared',
                                  shortIDescription:
                                      'Powerful AI Image Generator!',
                                  longDescription: ''' 
The Imagen AI Image Generator App is a cutting-edge, user-friendly application that harnesses the power of artificial intelligence to revolutionize the way you create and customize images. Whether you're a professional graphic designer, a content creator, or just someone looking to add a creative touch to your photos, Imagen AI is the perfect tool to bring your imagination to life.

Key Features:
AI-Powered Image Generation: Imagen AI employs advanced deep learning algorithms to generate high-quality images based on your inputs. Simply describe your vision or select from a variety of Presets, and watch as the app transforms your ideas into stunning visuals.

Customizable Art Styles: Imagen AI offers a wide range of artistic styles and filters to suit your preferences. From classic oil painting to modern abstract art, you can choose from an extensive library of styles to give your images a unique and personalized touch.

Intuitive Interface: Our user-friendly interface is designed to make the creative process effortless. Whether you're a beginner or an experienced designer, you'll find it easy to navigate the app and create captivating images.

Real-Time Preview: Imagen AI provides real-time previews of your edits, allowing you to see the changes as you make them. This feature ensures that you have full control over the final result and can make adjustments on the fly.

Choose Resolution: Imagen AI allows you to select your desired resolution, ensuring that your generated images are tailored to your specific needs, whether it's for web use, printing, or social media.

Privacy and Security: We prioritize your privacy and ensure that your images and data are secure. Imagen AI does not store or use your data for any purpose other than generating and editing images.

Regular Updates: Our development team is committed to improving Imagen AI continually. You can expect regular updates with new features, styles, and enhancements to keep your creative process fresh and exciting.

Who Can Benefit:
Graphic Designers: Imagen AI empowers graphic designers to streamline their workflow and explore new artistic avenues.

Content Creators: Bloggers, social media influencers, and YouTubers can use Imagen AI to create eye-catching visuals that engage their audience.

Photographers: Enhance and stylize your photos with ease, making each image a work of art.

Art Enthusiasts: Whether you're an amateur or a professional artist, Imagen AI opens up endless possibilities for creative expression.

Businesses: Imagen AI can be a valuable asset for marketing, branding, and advertising purposes, helping businesses stand out in a crowded digital landscape.

Experience the future of image generation and unleash your creativity with the Imagen AI Image Generator App. Download it today and turn your ideas into stunning visuals like never before. Immerse yourself in a world where art meets technology, and let your imagination run wild. With the option to choose your resolution, you have even more control over the quality and purpose of your generated images.

Copyright (c) 2023 Cupertino Studios
All rights reserved.
''',
                                  category: 'Tools',
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          AppCard(
                            appName: 'Audify',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(context, '/appPage',
                                  arguments: AppPageArguments(
                                    title: 'Audify',
                                    appLogo:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus.png?alt=media&token=e9186ad5-f6ff-4e0a-b23b-e42bfbc1dc74',
                                    appImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
                                    appName: 'Audify',
                                    highlightsIcon1: CupertinoIcons.music_note,
                                    highlightsIcon2:
                                        CupertinoIcons.radiowaves_left,
                                    highlightsIcon3: CupertinoIcons.doc_text,
                                    highlightsTitle1: 'Music Player',
                                    highlightsTitle2: 'Audify Recognition',
                                    highlightsTitle3: 'Lyrics',
                                    highlightsDescrition1:
                                        'Listen to your favorite songs on the go.',
                                    highlightsDescrition2:
                                        'Recognize song playing in background.',
                                    highlightsDescrition3:
                                        'Sing along with song lyrics.',
                                    phoneImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-phone-image.png?alt=media&token=3a793555-6c44-444b-96e0-5ccabd91e24e',
                                    privacyPolicyUrl:
                                        'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
                                    shortDescription:
                                        'The high quality Music Player',
                                    playStoreUrl:
                                        "https://play.google.com/store/apps/details?id=com.audify.android",
                                    appGalleryUrl:
                                        "https://appgallery.huawei.com/app/C106997283",
                                    featureImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9',
                                    androidUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify.apk?alt=media&token=ee237e98-be46-4874-afa6-44b104aa9812',
                                    iosUrl: '',
                                    linuxUrl: '',
                                    macUrl: '',
                                    windowsUrl: '',
                                    containsAds: false,
                                    iap: false,
                                    imageUrls: [
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FAudify%20recognition.png?alt=media&token=e022e9cb-dbb3-4011-abd0-4197209b18d0",
                                    ],
                                    installs: '10+',
                                    rating: '3+',
                                    whatsNew: 'Bug Fixes',
                                    dataSafety:
                                        'No data is collected or shared',
                                    shortIDescription:
                                        'High Quality Music Player with lyrics and Audio Recognition!',
                                    longDescription: ''' 
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
                                    category: 'Music and Audio',
                                  ));
                            },
                          ),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                  title: 'Audify Music Player',
                                  appLogo:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify.png?alt=media&token=ae77d914-55e2-4f3d-a129-280777621d93',
                                  shortDescription:
                                      'The high quality     Music Player',
                                  appImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-songs.png?alt=media&token=54f9353d-133a-48da-9b31-a7b9ca8f349a',
                                  appName: 'Audify Music Player',
                                  playStoreUrl:
                                      "https://play.google.com/store/apps/details?id=com.music.audify",
                                  appGalleryUrl:
                                      "https://appgallery.huawei.com/app/C108258673",
                                  appStoreUrl:
                                      "https://www.apple.com/app-store/",
                                  phoneImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-phone-image.png?alt=media&token=3a793555-6c44-444b-96e0-5ccabd91e24e',
                                  privacyPolicyUrl:
                                      'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
                                  highlightsIcon1: CupertinoIcons.music_note_2,
                                  highlightsTitle1: 'Music Player',
                                  highlightsDescrition1:
                                      'Listen to your favorite songs on the go.',
                                  highlightsIcon2: CupertinoIcons.wrench,
                                  highlightsTitle2: 'Theme Customization',
                                  highlightsDescrition2:
                                      'Customize theme to your taste.',
                                  highlightsIcon3: CupertinoIcons.doc_text,
                                  highlightsTitle3: 'Lyrics',
                                  highlightsDescrition3:
                                      'Sing along with song lyrics.',
                                  featureImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify-feature.png?alt=media&token=e8a6501c-02c3-49f9-b5f2-02c2e98fe545',
                                  androidUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-music-player-files%2Faudify-music-player.apk?alt=media&token=ce7a31ab-0e34-4309-be6e-7cddc1f636fa',
                                  iosUrl: '',
                                  linuxUrl: '',
                                  macUrl: '',
                                  windowsUrl: '',
                                  containsAds: false,
                                  iap: true,
                                  imageUrls: [
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Faudify-plus-feature.png?alt=media&token=fa08636b-2911-43ff-919d-116284729ec9",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(1).png?alt=media&token=9e56a3c2-b3bf-4e04-b4df-2ddefa7c4008",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(2).png?alt=media&token=1742833f-970c-4370-9498-6381bf2bc335",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(3).png?alt=media&token=9737f598-cff2-4849-960f-4dc4f543fb2f",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(4).png?alt=media&token=0302b187-76a0-48ac-a195-7ced71872b69",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2)%20(5).png?alt=media&token=1ea9bbd8-8ae4-4da7-bcaf-b282d075d0ee",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/audify-files%2Fscreenshots%2FScreenshot_20230612-073548%20(2).png?alt=media&token=36f10465-0540-4b90-9071-a81b3eea313c",
                                  ],
                                  installs: '1k+',
                                  rating: '3+',
                                  whatsNew: 'Bug Fixes',
                                  dataSafety: 'No data is collected or shared',
                                  shortIDescription:
                                      'High Quality Music Player with lyrics!',
                                  longDescription: ''' 
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
                                  category: 'Music and Audio',
                                ),
                              );
                            },
                          ),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                    title: 'GPA Calculator',
                                    appLogo:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator.png?alt=media&token=430c34d6-f8f6-48af-b423-e1ccb72729e8',
                                    shortDescription:
                                        'The high qualityGrade Calculator',
                                    appImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpacalculator-grades.png?alt=media&token=bcad79f4-a962-4fe2-87a6-ad48d9367e52',
                                    appName: 'GPA Calculator',
                                    playStoreUrl:
                                        "https://play.google.com/store/apps/details?id=com.anderson.gpa_calculator",
                                    appGalleryUrl:
                                        "https://appgallery.huawei.com/app/C106977151",
                                    appStoreUrl:
                                        "https://www.apple.com/app-store/",
                                    phoneImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943',
                                    privacyPolicyUrl:
                                        'https://www.privacypolicies.com/live/919bba91-173c-4699-8191-c0781afc0ee9',
                                    highlightsIcon1:
                                        CupertinoIcons.graph_circle,
                                    highlightsTitle1: 'Real Time Grading',
                                    highlightsDescrition1:
                                        'Calculate your grades on the go.',
                                    highlightsIcon2: CupertinoIcons.headphones,
                                    highlightsTitle2: 'Get Support',
                                    highlightsDescrition2:
                                        'Get Support from Admin.',
                                    highlightsIcon3:
                                        CupertinoIcons.conversation_bubble,
                                    highlightsTitle3: 'Request Features',
                                    highlightsDescrition3:
                                        'Request more features.',
                                    featureImage:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943',
                                    androidUrl:
                                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpacalculator.apk?alt=media&token=6a1df79e-6114-4e6a-bfab-e9a22baa4555',
                                    iosUrl: '',
                                    linuxUrl: '',
                                    macUrl: '',
                                    windowsUrl: '',
                                    containsAds: true,
                                    iap: false,
                                    imageUrls: [
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fgpa-calculator-feature.png?alt=media&token=26e4cdfc-9232-474b-9ee7-6e8c5d912943",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fscreenshots%2Fgpacalculator-phone-image.png?alt=media&token=b0b11b0f-1dc8-42e1-bdad-32fb7d8be97b",
                                      "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/gpa-calculator-files%2Fscreenshots%2Fgpacalculator-support.png?alt=media&token=98e7cd8a-034b-4175-864c-9fa793f35d48",
                                    ],
                                    installs: '100+',
                                    rating: '3+',
                                    whatsNew: 'Bug Fixes',
                                    dataSafety:
                                        'No data is collected or shared',
                                    shortIDescription:
                                        'High Quality Music Player with lyrics and Audio Recognition!',
                                    longDescription: ''' 
GPA Calculator is a mobile application that helps students in the 
University, colleges and other institution to calculate their grade 
point average managing all the formula complexity for students using 
the Nigeria and other country's grading system.
                                        ''',
                                    category: 'Tools'),
                              );
                            },
                          ),
                          AppCard(
                            appName: 'Imagen',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/appPage',
                                arguments: AppPageArguments(
                                  title: 'Imagen',
                                  appLogo:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen_black.png?alt=media&token=85def552-0002-40a9-b917-274cc0b704d5',
                                  shortDescription:
                                      'The Powerful AI Image Generator',
                                  appImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCamp%20Family.png?alt=media&token=aba6b809-baff-4a98-af5b-36b52c1e928d',
                                  appName: 'Imagen',
                                  playStoreUrl: "",
                                  appGalleryUrl:
                                      "https://appgallery.huawei.com/app/C109151501",
                                  appStoreUrl: "",
                                  phoneImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FEmotion%20or%20Mood-Based%20Prompts.png?alt=media&token=6f8bf915-59ed-4326-b8d4-62765233a1a0',
                                  privacyPolicyUrl:
                                      'https://www.privacypolicies.com/live/919bba91-173c-4699-8191-c0781afc0ee9',
                                  highlightsIcon1: CupertinoIcons.graph_circle,
                                  highlightsTitle1:
                                      'Real Time Image Generation',
                                  highlightsDescrition1:
                                      'Generate Powerful Images with Few prompts',
                                  highlightsIcon2: CupertinoIcons.paintbrush,
                                  highlightsTitle2: 'Customize Style',
                                  highlightsDescrition2:
                                      'Customize Image with preset styles.',
                                  highlightsIcon3: CupertinoIcons.resize,
                                  highlightsTitle3: 'Choose Image Resolution',
                                  highlightsDescrition3:
                                      'Select your desired Image Resolution.',
                                  featureImage:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5',
                                  androidUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen.apk?alt=media&token=ae262dbf-72fc-4796-93e0-cb64cc87a38f',
                                  iosUrl: '',
                                  linuxUrl: '',
                                  macUrl: '',
                                  windowsUrl: '',
                                  containsAds: false,
                                  iap: false,
                                  imageUrls: [
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FA%20close-up%20view%20of%20petal%20image.png?alt=media&token=7655da56-63a5-4d99-b78c-9423873582a8",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FArtwork%20Image%20Description.png?alt=media&token=ece0a75f-4e38-4554-8ab2-de6c83a7fab1",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCamp%20Family.png?alt=media&token=aba6b809-baff-4a98-af5b-36b52c1e928d",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCyberpunk%20Urban%20Setting.png?alt=media&token=3d9b7031-7f19-43df-b794-a1ea0ba86eb5",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FEmotion%20or%20Mood-Based%20Prompts.png?alt=media&token=6f8bf915-59ed-4326-b8d4-62765233a1a0",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FExperience%20Magical%20Image%20Generarion.png?alt=media&token=0d158b54-4572-4a65-92be-bcbf2f7de35c",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FHistorical%20or%20Cultural%20References%20(1).png?alt=media&token=d611818e-f84e-42c1-a962-24b968a11625",
                                    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FReference%20Image%20Using%20Artist%20Name.png?alt=media&token=20e4531c-0fe6-4da2-94c7-893e353b6442",
                                  ],
                                  installs: '100+',
                                  rating: '3+',
                                  whatsNew: 'Bug Fixes',
                                  dataSafety: 'No data is collected or shared',
                                  shortIDescription:
                                      'Powerful AI Image Generator!',
                                  longDescription: ''' 
The Imagen AI Image Generator App is a cutting-edge, user-friendly application that harnesses the power of artificial intelligence to revolutionize the way you create and customize images. Whether you're a professional graphic designer, a content creator, or just someone looking to add a creative touch to your photos, Imagen AI is the perfect tool to bring your imagination to life.

Key Features:
AI-Powered Image Generation: Imagen AI employs advanced deep learning algorithms to generate high-quality images based on your inputs. Simply describe your vision or select from a variety of Presets, and watch as the app transforms your ideas into stunning visuals.

Customizable Art Styles: Imagen AI offers a wide range of artistic styles and filters to suit your preferences. From classic oil painting to modern abstract art, you can choose from an extensive library of styles to give your images a unique and personalized touch.

Intuitive Interface: Our user-friendly interface is designed to make the creative process effortless. Whether you're a beginner or an experienced designer, you'll find it easy to navigate the app and create captivating images.

Real-Time Preview: Imagen AI provides real-time previews of your edits, allowing you to see the changes as you make them. This feature ensures that you have full control over the final result and can make adjustments on the fly.

Choose Resolution: Imagen AI allows you to select your desired resolution, ensuring that your generated images are tailored to your specific needs, whether it's for web use, printing, or social media.

Privacy and Security: We prioritize your privacy and ensure that your images and data are secure. Imagen AI does not store or use your data for any purpose other than generating and editing images.

Regular Updates: Our development team is committed to improving Imagen AI continually. You can expect regular updates with new features, styles, and enhancements to keep your creative process fresh and exciting.

Who Can Benefit:
Graphic Designers: Imagen AI empowers graphic designers to streamline their workflow and explore new artistic avenues.

Content Creators: Bloggers, social media influencers, and YouTubers can use Imagen AI to create eye-catching visuals that engage their audience.

Photographers: Enhance and stylize your photos with ease, making each image a work of art.

Art Enthusiasts: Whether you're an amateur or a professional artist, Imagen AI opens up endless possibilities for creative expression.

Businesses: Imagen AI can be a valuable asset for marketing, branding, and advertising purposes, helping businesses stand out in a crowded digital landscape.

Experience the future of image generation and unleash your creativity with the Imagen AI Image Generator App. Download it today and turn your ideas into stunning visuals like never before. Immerse yourself in a world where art meets technology, and let your imagination run wild. With the option to choose your resolution, you have even more control over the quality and purpose of your generated images.

Copyright (c) 2023 Cupertino Studios
All rights reserved.
''',
                                  category: 'Tools',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                Container(
                  color: Colors.grey[
                      200], // Set the desired background color for the footer
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '© 2023 Cupertino Studios. All rights reserved.', // Replace with your company name and year
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            overflow: TextOverflow.clip,
                            color: Colors.black54, // Set the desired text color
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AppCard extends StatelessWidget {
  final String appName;
  final String platform;
  final VoidCallback onPressed;

  const AppCard(
      {super.key,
      required this.appName,
      required this.platform,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appName,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip),
              ),
              const SizedBox(height: 10),
              Text(
                'Platform: $platform',
                style:
                    const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
