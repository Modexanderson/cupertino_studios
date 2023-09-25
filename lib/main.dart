import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

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
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/iosinstallation') {
      //     // Extract the route parameters if any
      //     final arguments = settings.arguments as Map<String, dynamic>?;

      //     return MaterialPageRoute(
      //       builder: (context) => AppInstallationPage(
      //         appName: arguments?['appName'] ?? '',
      //         appIcon: arguments?['appIcon'] ?? '',
      //         appDownloadUrl: arguments?['appDownloadUrl'] ?? '',
      //       ),
      //     );
      //   }
      //   // Handle other routes if needed
      //   return null;
      // },
      // routes: {
      //   // '': (context) => const CupertinoStudiosHomePage(),
      //   '/apppage': (context) =>  AppPage(),

      //   // '/iosinstallation': (context) => const AppInstallationPage(
      //   //       appDownloadUrl: '',
      //   //       appName: '',
      //   //     ),
      //   // Add other routes as needed
      // },
      theme: ThemeData(
        fontFamily: 'SFPRODISPLAYMEDIUM',
        appBarTheme: const AppBarTheme(
          iconTheme:
              IconThemeData(color: Colors.blue), // Customize app bar icon color
          backgroundColor: Colors.white,

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
      home: const HomePage(),
    );
  }
}
