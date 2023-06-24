import 'dart:ui';

import 'package:cupertino_studios/audifymusicplayer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audify_page.dart';
import 'gpacalculator_page.dart';
import 'ipainstallation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const CupertinoStudiosWebsite());
}

class CupertinoStudiosWebsite extends StatelessWidget {
  const CupertinoStudiosWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Studios',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/iosinstallation') {
          // Extract the route parameters if any
          final arguments = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => AppInstallationPage(
              appName: arguments?['appName'] ?? '',
              appIcon: arguments?['appIcon'] ?? '',
              appDownloadUrl: arguments?['appDownloadUrl'] ?? '',
            ),
          );
        }
        // Handle other routes if needed
        return null;
      },
      routes: {
        // '': (context) => const CupertinoStudiosHomePage(),
        '/audify': (context) => const AudifyPage(),
        '/audifymusicplayer': (context) => const AudifyMusicPlayerPage(),
        '/gpacalculator': (context) => const GPACalculatorPage(),
        // '/iosinstallation': (context) => const AppInstallationPage(
        //       appDownloadUrl: '',
        //       appName: '',
        //     ),
        // Add other routes as needed
      },
      theme: ThemeData(
        fontFamily: 'SFPRODISPLAYMEDIUM',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'SF Arch Rival Bold',
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Customize the font weight if desired
            // Other text style properties
          ),
        ),

        scaffoldBackgroundColor:
            Colors.grey[200], // Set the background color to gray
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          // primaryColor: CupertinoColors.white,
          // primaryContrastingColor: CupertinoColors.activeBlue,
          textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
              fontFamily: 'SF Arch Rival Bold',
              fontSize: 20, // Adjust the font size as needed
              fontWeight:
                  FontWeight.bold, // Customize the font weight if desired
              // Other text style properties
            ),
            textStyle: TextStyle(
              color: CupertinoColors.black,
              fontFamily: 'SFPRODISPLAYMEDIUM', // Set the San Francisco font
            ),
          ),
        ),
      ),
      home: const CupertinoStudiosHomePage(),
    );
  }
}

class CupertinoStudiosHomePage extends StatelessWidget {
  const CupertinoStudiosHomePage({super.key});
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
            padding: const EdgeInsets.only(left: 140, right: 140),
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
                            child: Image.asset('images/home-screen-image.jpg',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover),
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
                              Navigator.pushNamed(context, '/audify');
                            },
                          ),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/audifymusicplayer');
                            },
                          ),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(context, '/gpacalculator');
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
                              Navigator.pushNamed(context, '/audify');
                            },
                          ),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/audifymusicplayer');
                            },
                          ),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(context, '/gpacalculator');
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
