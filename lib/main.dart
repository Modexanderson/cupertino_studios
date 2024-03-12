import 'dart:io';

import 'package:cupertino_studios/screens/audify_music_player_page/android_page.dart';
import 'package:cupertino_studios/screens/audify_music_player_page/audifymusicplayer_page.dart';
import 'package:cupertino_studios/screens/audify_music_player_page/ios_page.dart';
import 'package:cupertino_studios/screens/audify_music_player_page/linux_page.dart';
import 'package:cupertino_studios/screens/audify_music_player_page/macos_page.dart';
import 'package:cupertino_studios/screens/audify_music_player_page/windows_page.dart';
import 'package:cupertino_studios/screens/audify_page/android_page.dart';
import 'package:cupertino_studios/screens/audify_page/ios_page.dart';
import 'package:cupertino_studios/screens/audify_page/linux_page.dart';
import 'package:cupertino_studios/screens/audify_page/macos_page.dart';
import 'package:cupertino_studios/screens/audify_page/windows_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/android_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/gpacalculator_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/ios_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/linux_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/macos_page.dart';
import 'package:cupertino_studios/screens/gpacalculator_page/windows_page.dart';
import 'package:cupertino_studios/screens/imagen_page/android_page.dart';
import 'package:cupertino_studios/screens/imagen_page/imagen_page.dart';
import 'package:cupertino_studios/screens/imagen_page/ios_page.dart';
import 'package:cupertino_studios/screens/imagen_page/linux_page.dart';
import 'package:cupertino_studios/screens/imagen_page/macos_page.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:cupertino_studios/screens/imagen_page/windows_page.dart';
import 'package:flutter/material.dart';

import 'screens/audify_page/audify_page.dart';
import 'screens/home_page.dart';
import 'screens/imagen_page/imagen_support.dart';

void main() async {
  runApp( const CupertinoStudiosWebsite(),
  );
  // Set up the shelf handler
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(createStaticHandler('web', defaultDocument: 'index.html'));

  // Serve static files (including sitemap.xml and robots.txt)
  var server = await io.serve(handler, InternetAddress.anyIPv4, 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}

class CupertinoStudiosWebsite extends StatelessWidget {
  const CupertinoStudiosWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Studios',
      debugShowCheckedModeBanner: false,
      routes: {
        // AUDIFY ROUTES
        '/audify': (context) => const AudifyPage(),
        '/audify/android': (context) => AudifyAndroidPage(),
        '/audify/iOS': (context) => AudifyiOSPage(),
        '/audify/linux': (context) => AudifyLinuxPage(),
        '/audify/macOS': (context) => AudifymacOSPage(),
        '/audify/windows': (context) => AudifyWindowsPage(),

        // AUDIFY MUSIC PLAYER ROUTES

        '/audifymusicplayer': (context) => const AudifyMusicPlayerPage(),
        '/audifymusicplayer/android': (context) =>
            AudifyMusicPlayerAndroidPage(),
        '/audifymusicplayer/iOS': (context) => AudifyMusicPlayeriOSPage(),
        '/audifymusicplayer/linux': (context) => AudifyMusicPlayerLinuxPage(),
        '/audifymusicplayer/macOS': (context) => AudifyMusicPlayermacOSPage(),
        '/audifymusicplayer/windows': (context) =>
            AudifyMusicPlayerWindowsPage(),

        // GPA Calculator ROUTES

        '/gpacalculator': (context) => const GPACalculatorPage(),
        '/gpacalculator/android': (context) => GPACalculatorAndroidPage(),
        '/gpacalculator/iOS': (context) => GPACalculatoriOSPage(),
        '/gpacalculator/linux': (context) => GPACalculatorLinuxPage(),
        '/gpacalculator/macOS': (context) => GPACalculatormacOSPage(),
        '/gpacalculator/windows': (context) => GPACalculatorWindowsPage(),

        // IMAGEN ROUTES

        '/imagen': (context) => const ImagenPage(),
        '/imagen/android': (context) => ImagenAndroidPage(),
        '/imagen/iOS': (context) => ImageniOSPage(),
        '/imagen/linux': (context) => ImagenLinuxPage(),
        '/imagen/macOS': (context) => ImagenmacOSPage(),
        '/imagen/windows': (context) => ImagenWindowsPage(),
        '/imagensupport': (context) =>  const ImagenSupport(),

        // '/support': (context) =>  const SupportPage(),
        '/homePage': (context) => const HomePage()
      },
      theme: ThemeData(
        fontFamily: 'SFPRODISPLAYMEDIUM',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.blue,
          ), // Customize app bar icon color
          backgroundColor: Colors.white,

          titleTextStyle: TextStyle(
            fontFamily: 'SF Arch Rival Bold',
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Customize the font weight if desired
            // Other text style properties
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Replace with your desired color
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
