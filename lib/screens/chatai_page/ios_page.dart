import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class ChatAiiOSPage extends StatelessWidget {
  ChatAiiOSPage({super.key});

  final containsAds = false;
  final iap = true;

  final imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fchat%20AI%20feature%20graphic.png?alt=media&token=b74770fb-5437-4442-a7b0-a20a123fafbf",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fscreenshots%2Fnew%20chat%20session.png?alt=media&token=8e1e30a8-2d90-48a6-b36e-65e1cc35c8d2",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fscreenshots%2Fexperience%20chat.png?alt=media&token=bcd38fef-82db-41c7-89b9-22e984de250f",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fscreenshots%2Fhistory.png?alt=media&token=091df1e6-54c4-4ad7-be6a-299079eedf70",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fscreenshots%2Fbackup%20chat.png?alt=media&token=76340ce0-244e-4927-ba0f-e594c6b41029",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Fscreenshots%2Fsettings.png?alt=media&token=17a77bbf-5bdd-41c7-b03a-afa77f39487f",
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
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
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
                        'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/chatai-files%2Flogo.png?alt=media&token=22337d27-8258-458e-ae12-62804e80d30d', // Replace with your app's icon URL
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
                      _launchURL(
                          'https://apps.apple.com/us/developer/mordecai-gaza-abraham/id1732452052');
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
