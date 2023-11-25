import 'package:cupertino_studios/models/.env.dart';
import 'package:cupertino_studios/screens/app_installation_page.dart';
import 'package:cupertino_studios/screens/support_page.dart';
import 'package:cupertino_studios/stripe_pay/stripe_pay.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'binance_pay/binance_pay.dart';
import 'screens/app_page.dart';
import 'screens/home_page.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BinancePayState()),
        ChangeNotifierProvider(create: (context) => StripePayState()),
        // Add other providers as needed
      ],
      child: const CupertinoStudiosWebsite(),
    ),
    );
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
        '/supportPage': (context) => const SupportPage(),
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
