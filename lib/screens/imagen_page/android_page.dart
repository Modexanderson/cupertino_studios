import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon_widget.dart';
import '../../widgets/horizontal_scrolling_list.dart';

class ImagenAndroidPage extends StatelessWidget {
  ImagenAndroidPage({super.key});

  final containsAds = false;
  final iap = true;

  final imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fimagen-feature-graphics.png?alt=media&token=39b551ea-4572-4334-b726-533e0b5a3fa5",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Fcraft%20masterpiece.png?alt=media&token=dffdf2a2-bc7f-4b1d-afdc-cb8d70747502",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Felevate%20preset.png?alt=media&token=20305d57-9328-41ae-8f29-521e4c5b3cb1",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Ftrack%20image%20story.png?alt=media&token=2cd33cd7-8b53-4908-8d37-42f3691747a6",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Fdefine%20resolution.png?alt=media&token=fa75259b-25ec-44ae-ba25-8b161626af12",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Funleash%20style.png?alt=media&token=d9d42965-bc49-4a14-bcb6-b9374656048c",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Fshare%20or%20erase%2C%20dark.png?alt=media&token=b166a116-2f26-4a91-a6fd-f89b729f693f",
    "https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/imagen-files%2Fscreenshots%2Fbackup%20masterpiece.png?alt=media&token=c7f0e470-3e4f-4711-9ab3-04801d9dd5b8",
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
                        '1k+',
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
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '''
Added image history feature.
Added share or delete image options.
Added image history backup options and auto backup.
FIne tuned image creation function.
Redesigned home screen for a more intuitive navigation.
Stay tuned for upcoming features like real-time images an prompt sharing!
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
                    'Basic AI Image App!',
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

Track Image History: Effortlessly trace your creative journey by exploring the history of your generated images. Revisit and appreciate the evolution of your artistic endeavors.

Intuitive Interface: Our user-friendly interface is designed to make the creative process effortless. Whether you're a beginner or an experienced designer, you'll find it easy to navigate the app and create captivating images.

Real-Time Preview: Imagen AI provides real-time previews of your edits, allowing you to see the changes as you make them. This feature ensures that you have full control over the final result and can make adjustments on the fly.

Choose Resolution: Imagen AI allows you to select your desired resolution, ensuring that your generated images are tailored to your specific needs, whether it's for web use, printing, or social media.

Image History Backup: Safeguard your precious creations locally with our robust backup feature. Enjoy the peace of mind knowing that your image history is securely stored for future reference.

Share or Erase Image: Seamlessly manage your generated images. Choose to share your masterpieces with the world or erase them with a simple tap, giving you complete control over your gallery.

Localize Feature: Immerse yourself in a personalized experience with our localization feature. Tailor the app to your preferences and language, enhancing your creative process.

Theme Selection Feature: Express your unique style with our theme selection feature. Customize the app's appearance to match your mood, creating a visually pleasing environment for your creative exploration.

Auto Backup Option: Never worry about losing your creations. Enable the auto backup option to automatically secure your image history, ensuring that every stroke of creativity is preserved.

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
