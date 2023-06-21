import 'dart:html' as html;
import 'package:flutter/material.dart';

class AppInstallationPage extends StatelessWidget {
  final String appName;
  final String appIcon;
  final String appDownloadUrl;

  const AppInstallationPage({
    super.key,
    required this.appName,
    required this.appIcon,
    required this.appDownloadUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Installation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.apps,
                    size: 32,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Image.asset(
              appIcon, // Replace with the path to your app icon image
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                downloadAppBundle(appDownloadUrl);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Install',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void downloadAppBundle(String downloadUrl) {
    html.window.location.href = downloadUrl;
  }

  // void downloadAppBundle(String downloadUrl) {
  //   final html.AnchorElement anchor = html.AnchorElement(href: downloadUrl)
  //     ..setAttribute('download', '');

  //   // Programmatically click the anchor element to start the download
  //   anchor.click();
  // }
  // Future<void> downloadAppBundle(String downloadUrl) async {
  //   final Uri uri = Uri.parse(downloadUrl);
  //   final http.Response response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     final String fileName = uri.pathSegments
  //         .last; // Use the last segment of the URL as the file name
  //     final Directory appDirectory = await getApplicationDocumentsDirectory();
  //     final String filePath = '${appDirectory.path}/$fileName';

  //     final File file = File(filePath);
  //     await file.writeAsBytes(response.bodyBytes);

  //     // Open the file for the user to install
  //     OpenFile.open(filePath);
  //   } else {
  //     throw Exception('Failed to download the iOS app bundle.');
  //   }
  // }
}
