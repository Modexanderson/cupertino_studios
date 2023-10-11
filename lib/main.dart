import 'package:cupertino_studios/app_installation_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_page.dart';
import 'home_page.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const CupertinoStudiosWebsite());
  // Initialize routes
  final appRouter = AppRouter();
  appRouter.defineRoutes();
}

class CupertinoStudiosWebsite extends StatelessWidget {
  const CupertinoStudiosWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Studios',
      debugShowCheckedModeBanner: false,
      routes: {
        // '': (context) => const CupertinoStudiosHomePage(),
        '/appPage': (context) => const AppPage(),
        '/appInstallationPage': (context) => AppInstallationPage(),
        '/homePage': (context) => const HomePage()
      },
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
        
      ),
      home: const HomePage(),
    );
  }
}
