import 'package:cupertino_studios/audifymusicplayer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audify_page.dart';
import 'gpacalculator_page.dart';
import 'ipainstallation_page.dart';

void main() {
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
            fontFamily: 'HACKED',
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
              fontFamily: 'HACKED',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                      CupertinoColors.black, BlendMode.srcIn),
                  child: Image.asset(
                    'icons/logo-no-background.png',
                    width: MediaQuery.of(context).size.width * 0.35,

                    fit: BoxFit.cover,
                    // alignment: Alignment.topCenter,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Cupertino Studios',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'We build beautiful and powerful mobile apps.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Contact Us'),
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'mailto:cupertinostudios@gmail.com%26subject%3DRegarding%2520Mobile%2520App',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Our Apps',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              Row(
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
                      Navigator.pushNamed(context, '/audifymusicplayer');
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
            ],
          ),
        ),
      ),
    );
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
            children: <Widget>[
              Text(
                appName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Platform: $platform',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
