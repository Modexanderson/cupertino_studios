import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:binance_pay/binance_pay.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'cupertinostudios@gmail.com',
      queryParameters: {
        'body': 'Hello, ',
      },
    );

    if (await canLaunchUrl(Uri.parse(emailUri.toString()))) {
      await launchUrl(Uri.parse(emailUri.toString()));
    } else {
      throw 'Could not launch email';
    }
  }
  //  Future<void> makePayment(BuildContext context, String amount) async {
  //   BinancePay pay = BinancePay(
  //     apiKey: apiKey,
  //     apiSecretKey: apiSecret,
  //   );

  //   String tradeNo = generateMerchantTradeNo();

  //   OrderResponse response = await pay.createOrder(
  //     body: RequestBody(
  //       merchantTradeNo: tradeNo,
  //       orderAmount: amount,
  //       currency: 'BUSD',
  //       goodsType: '01',
  //       goodsCategory: '1000',
  //       referenceGoodsId: 'referenceGoodsId',
  //       goodsName: 'donation',
  //       goodsDetail: 'donation',
  //     ),
  //   );

  //   debugPrint(response.toString());

  //   QueryResponse queryResponse = await pay.queryOrder(
  //     merchantTradeNo: tradeNo,
  //     prepayId: response.data!.prepayId,
  //   );

  //   debugPrint(queryResponse.status);

  //   CloseResponse closeResponse = await pay.closeOrder(
  //     merchantTradeNo: tradeNo,
  //   );

  //   debugPrint(closeResponse.status);
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          CupertinoColors.black, BlendMode.srcIn),
                      child: Image.asset(
                        'icons/logo-no-background.png',
                        width: MediaQuery.of(context).size.width * 0.09,
                        // height: 100,

                        fit: BoxFit.contain,
                        // alignment: Alignment.topCenter,
                      ),
                    ),
                    constraints.maxWidth < 900
                        ? const Expanded(
                            child: Text(
                              'Welcome to Cupertino Studios',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 123.0),
                              child: Text(
                                'Welcome to Cupertino Studios',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/supportPage');
                    //     },
                    //     child: const Text('Support')),
                  ],
                ),
                const SizedBox(height: 20),
                const Card(
                  child: Text(
                    'We build beautiful and powerful mobile apps.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/home-screen-image.jpg?alt=media&token=bdf46aa0-6c06-4ac9-8cb3-ce5f67dc0413',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover, // Adjust the image's fit
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                // width: 800,
                                child: Text(
                                  '"High-quality mobile apps are more than just lines of code. They are seamless experiences, crafted with precision and care, that delight users and solve their everyday challenges."',
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 700 ? 16 : 25,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Contact Us'),
                  onPressed: () {
                    sendEmail();
                  },
                ),
                const SizedBox(height: 20),
                Card(
                  child: Text(
                    'Our Apps',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                constraints.maxWidth < 900
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppCard(
                            appName: 'Audify',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/audify',
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/audifymusicplayer',
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/gpacalculator',
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          AppCard(
                            appName: 'Imagen',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/imagen',
                              );
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppCard(
                            appName: 'Audify',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/audify',
                              );
                            },
                          ),
                          AppCard(
                            appName: 'Audify Music Player',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/audifymusicplayer',
                              );
                            },
                          ),
                          AppCard(
                            appName: 'GPA Calculator',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/gpacalculator',
                              );
                            },
                          ),
                          AppCard(
                            appName: 'Imagen',
                            platform: 'Android, iOS',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/imagen',
                              );
                            },
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Text(
                    'Our App Development Pricing',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                constraints.maxWidth < 900
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          PricingCard(
                            title: 'Basic Package',
                            description:
                                'Perfect for small businesses and startups',
                            price: '\$299 - \$799',
                            features: const [
                              'Up to 5 pages',
                              'Basic UI/UX design',
                              '1-2 app integrations',
                              'Limited support',
                            ],
                          ),
                          const SizedBox(height: 20),
                          PricingCard(
                            title: 'Pro Package',
                            description: 'Great for growing businesses',
                            price: '\$799 - \$1,499',
                            features: const [
                              'Up to 10 pages',
                              'Custom UI/UX design',
                              '3-5 app integrations',
                              'Priority support',
                            ],
                          ),
                          const SizedBox(height: 20),
                          PricingCard(
                            title: 'Enterprise Package',
                            description:
                                'Tailored solutions for large enterprises',
                            price: '\$1,500+',
                            features: const [
                              'Custom number of pages',
                              'Highly polished UI/UX design',
                              'Advanced app integrations',
                              '24/7 premium support',
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PricingCard(
                            title: 'Basic Package',
                            description:
                                'Perfect for small businesses and startups',
                            price: '\$299 - \$799',
                            features: const [
                              'Up to 5 pages',
                              'Basic UI/UX design',
                              '1-2 app integrations',
                              'Limited support',
                            ],
                          ),
                          PricingCard(
                            title: 'Pro Package',
                            description: 'Great for growing businesses',
                            price: '\$799 - \$1,499',
                            features: const [
                              'Up to 10 pages',
                              'Custom UI/UX design',
                              '3-5 app integrations',
                              'Priority support',
                            ],
                          ),
                          PricingCard(
                            title: 'Enterprise Package',
                            description:
                                'Tailored solutions for large enterprises',
                            price: '\$1,500+',
                            features: const [
                              'Custom number of pages',
                              'Highly polished UI/UX design',
                              'Advanced app integrations',
                              '24/7 premium support',
                            ],
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                const FAQSection(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.grey[
                      200], // Set the desired background color for the footer
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '© 2023 Cupertino Studios. All rights reserved.', // Replace with your company name and year
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            overflow: TextOverflow.clip,
                            color: Colors.black54, // Set the desired text color
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class AppCard extends StatelessWidget {
  final String appName;
  final String platform;
  final VoidCallback onPressed;

  const AppCard(
      {super.key,
      required this.appName,
      required this.platform,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appName,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip),
              ),
              const SizedBox(height: 10),
              Text(
                'Platform: $platform',
                style:
                    const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final List<String> features;

  PricingCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => AppDescriptionPage(title: title),
          //   ),
          // );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: $price',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features
                    .map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check,
                                  size: 14, color: Colors.green),
                              const SizedBox(width: 5),
                              Text(feature),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          FAQItem(
            question: 'What does "3-5 app integrations" mean?',
            answer:
                'In the context of our pricing packages, "3-5 app integrations" refers to the number of external services or functionalities that we can integrate into your mobile app. Examples include social media logins, payment gateways, maps, push notifications, or any other third-party APIs to enhance your app\'s capabilities.',
          ),
          const SizedBox(height: 20),
          FAQItem(
            question: 'How long does it take to develop a mobile app?',
            answer:
                'The timeline for mobile app development varies based on the complexity of the project, features required, and client feedback. A basic app may take a few weeks, while more complex apps can take several months. We work closely with clients to provide realistic timelines and milestones.',
          ),
          const SizedBox(height: 20),
          FAQItem(
            question: 'Do you offer post-launch support?',
            answer:
                'Yes, we offer post-launch support to address any issues, bugs, or additional features you may need. The level of support depends on the chosen pricing package. Our goal is to ensure your app functions smoothly and evolves according to your business needs.',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
