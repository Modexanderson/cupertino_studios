import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class ChatAimacOSPage extends StatelessWidget {
  ChatAimacOSPage({super.key});

  final containsAds = false;
  final iap = true;

  final imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FA%20close-up%20view%20of%20petal%20image.png?alt=media&token=7655da56-63a5-4d99-b78c-9423873582a8",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FArtwork%20Image%20Description.png?alt=media&token=ece0a75f-4e38-4554-8ab2-de6c83a7fab1",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCamp%20Family.png?alt=media&token=aba6b809-baff-4a98-af5b-36b52c1e928d",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FCyberpunk%20Urban%20Setting.png?alt=media&token=3d9b7031-7f19-43df-b794-a1ea0ba86eb5",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FEmotion%20or%20Mood-Based%20Prompts.png?alt=media&token=6f8bf915-59ed-4326-b8d4-62765233a1a0",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FExperience%20Magical%20Image%20Generarion.png?alt=media&token=0d158b54-4572-4a65-92be-bcbf2f7de35c",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FHistorical%20or%20Cultural%20References%20(1).png?alt=media&token=d611818e-f84e-42c1-a962-24b968a11625",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2FReference%20Image%20Using%20Artist%20Name.png?alt=media&token=20e4531c-0fe6-4da2-94c7-893e353b6442",
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
                'Chat AI',
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
                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen_black.png?alt=media&token=85def552-0002-40a9-b917-274cc0b704d5', // Replace with your app's icon URL
                    size: 100.0, // Specify the size you desire
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        '100+',
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
                          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen.apk?alt=media&token=8a3b3117-e833-41d7-b444-82fd8ab5bf9c'); // Replace with your download logic
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
                child: Column(children: [
                  Text(
                    'No data is collected or shared',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ]),
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
                    'AI Powered Chat App!',
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
Chat AI is a groundbreaking application designed to enhance your communication experience through the power of artificial intelligence. Whether you're chatting with friends, family, or seeking advice from AI, Chat AI is the perfect companion for engaging conversations.

Key Features:
AI-Powered Conversations: Chat AI utilizes advanced natural language processing to facilitate meaningful and dynamic conversations. Simply start a chat, and watch as the AI responds intelligently to your queries and comments.

Customizable Chat Experience: Tailor your chat environment with various themes and layouts, making each conversation unique to your style.

Chat History Tracking: Easily access and revisit your past conversations. Our chat history feature allows you to keep track of important discussions and memories.

User-Friendly Interface: Designed with simplicity in mind, Chat AI's intuitive interface makes it easy to navigate and enjoy seamless communication.

Real-Time Messaging: Experience instant messaging capabilities, ensuring your conversations flow without delay.

Privacy Controls: Your privacy is our priority. With robust security features, you can manage your data and ensure your conversations remain confidential.

Backup and Restore: Safeguard your chat history with our backup feature. Automatically save your conversations for future reference and restore them whenever needed.

Share and Manage Chats: Effortlessly share chat excerpts or delete messages with a simple tap, giving you full control over your communication.

Localization: Enjoy a personalized experience with our localization feature, allowing you to use the app in your preferred language.

Regular Updates: Our development team is committed to enhancing Chat AI continuously. Expect regular updates with new features and improvements to keep your chat experience fresh and engaging.

Who Can Benefit:
Everyone: Whether you're a casual user, a professional, or someone who enjoys AI interactions, Chat AI is designed for all.

Families: Keep in touch with family members effortlessly, sharing stories and experiences in a secure environment.

Professionals: Enhance your communication skills and gather insights on various topics through engaging conversations.

Students: Utilize Chat AI as a learning tool to ask questions and receive instant explanations.

Experience the future of communication and elevate your chatting experience with Chat AI. Download it today and explore a world where AI meets conversation, unlocking endless possibilities for interaction.

Copyright (c) 2023 Cupertino Studios
All rights reserved.
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
                  'Tools',
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
