import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'app_installation_page.dart'; // If you're using the Fluro package

class AppRouter {
  static FluroRouter router = FluroRouter();

  void defineRoutes() {
    router.define(
      '/appInstallationPage/:appId',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          final String? appId = params['appId'];
          // Use 'appId' to display app-specific information
          return AppInstallationPage(); // Replace with your shared page widget
        },
      ),
    );
  }
}
