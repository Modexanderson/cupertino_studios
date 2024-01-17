import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class ImageniOSPage extends StatelessWidget {
  ImageniOSPage({super.key});

  
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
                'Imagen',
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
                children:  [
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
                    'Powerful AI Image Generator!',
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
The Imagen AI Image Generator App is a cutting-edge, user-friendly application that harnesses the power of artificial intelligence to revolutionize the way you create and customize images. Whether you're a professional graphic designer, a content creator, or just someone looking to add a creative touch to your photos, Imagen AI is the perfect tool to bring your imagination to life.

Key Features:
AI-Powered Image Generation: Imagen AI employs advanced deep learning algorithms to generate high-quality images based on your inputs. Simply describe your vision or select from a variety of Presets, and watch as the app transforms your ideas into stunning visuals.

Customizable Art Styles: Imagen AI offers a wide range of artistic styles and filters to suit your preferences. From classic oil painting to modern abstract art, you can choose from an extensive library of styles to give your images a unique and personalized touch.

Intuitive Interface: Our user-friendly interface is designed to make the creative process effortless. Whether you're a beginner or an experienced designer, you'll find it easy to navigate the app and create captivating images.

Real-Time Preview: Imagen AI provides real-time previews of your edits, allowing you to see the changes as you make them. This feature ensures that you have full control over the final result and can make adjustments on the fly.

Choose Resolution: Imagen AI allows you to select your desired resolution, ensuring that your generated images are tailored to your specific needs, whether it's for web use, printing, or social media.

Privacy and Security: We prioritize your privacy and ensure that your images and data are secure. Imagen AI does not store or use your data for any purpose other than generating and editing images.

Regular Updates: Our development team is committed to improving Imagen AI continually. You can expect regular updates with new features, styles, and enhancements to keep your creative process fresh and exciting.

Who Can Benefit:
Graphic Designers: Imagen AI empowers graphic designers to streamline their workflow and explore new artistic avenues.

Content Creators: Bloggers, social media influencers, and YouTubers can use Imagen AI to create eye-catching visuals that engage their audience.

Photographers: Enhance and stylize your photos with ease, making each image a work of art.

Art Enthusiasts: Whether you're an amateur or a professional artist, Imagen AI opens up endless possibilities for creative expression.

Businesses: Imagen AI can be a valuable asset for marketing, branding, and advertising purposes, helping businesses stand out in a crowded digital landscape.

Experience the future of image generation and unleash your creativity with the Imagen AI Image Generator App. Download it today and turn your ideas into stunning visuals like never before. Immerse yourself in a world where art meets technology, and let your imagination run wild. With the option to choose your resolution, you have even more control over the quality and purpose of your generated images.

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
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
