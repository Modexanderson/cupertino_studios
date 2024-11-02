// ignore_for_file: unnecessary_const

import 'package:cupertino_studios/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  final String email = 'cupertinostudios@gmail.com';
  final String phone = '+2348173227654';
  final String website = 'https://cupertinostudios.github.io/';

  const SupportPage({super.key});

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
          appBar: const CupertinoNavigationBar(
            middle: Text(
              'Cupertino Studios Support',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: constraints.maxWidth < 900
                  ? const EdgeInsets.only(left: 10, right: 10)
                  : const EdgeInsets.only(left: 140, right: 140),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Padding(
                      padding: constraints.maxWidth < 900
                          ? const EdgeInsets.all(10.0)
                          : const EdgeInsets.all(4.0),
                      child: Column(children: <Widget>[
                        const Text(
                          'Welcome to Cupertino Studios support page!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'If you have any questions, feedback, or encounter any issues with our app, please feel free to contact us:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _launchURL('mailto:$email'),
                              icon: const Icon(Icons.email),
                              label: const Text('Email'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () => _launchURL('tel:$phone'),
                              icon: const Icon(Icons.phone),
                              label: const Text('Phone'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'You can also visit our website for more information:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _launchURL(website),
                          child: const Text('Visit Website'),
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Card(
                    child: const Text(
                      'Frequently Asked Questions',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FAQItem(
                    question: 'How do I reset my password?',
                    answer:
                        'You can reset your password by clicking on the "reset password" text in the login page.',
                  ),
                  FAQItem(
                    question: 'Why am I unable to log in?',
                    answer:
                        'Make sure you are using the correct email address and password. If you are still unable to log in, please contact support for further assistance.',
                  ),
                  FAQItem(
                    question: 'How can I update the app?',
                    answer:
                        'You can update the app from the App Store or Google Play Store, depending on your device.',
                  ),
                  FAQItem(
                    question: 'How can I purchase Imagen credits?',
                    answer:
                        'You can update purchase Imagen credits by tapping on the credit amount icon at the app bar, and tapping "Recharge Now" for options',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ));
    });
  }
}
