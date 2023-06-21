import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PagesWidget extends StatefulWidget {
  final String title;
  final String appLogo;
  final String appImage;
  final String appName;
  final String appDownloadUrl;
  final IconData highlightsIcon1;
  final IconData highlightsIcon2;
  final IconData highlightsIcon3;
  final String highlightsTitle1;
  final String highlightsTitle2;
  final String highlightsTitle3;
  final String highlightsDescrition1;
  final String highlightsDescrition2;
  final String highlightsDescrition3;
  final String phoneImage;
  final String privacyPolicyUrl;
  final String shortDescription;
  final String playStoreUrl;
  final String? appStoreUrl;
  final String featureImage;
  const PagesWidget({
    required this.title,
    required this.appLogo,
    required this.appImage,
    required this.appName,
    required this.appDownloadUrl,
    required this.highlightsIcon1,
    required this.highlightsIcon2,
    required this.highlightsIcon3,
    required this.highlightsTitle1,
    required this.highlightsTitle2,
    required this.highlightsTitle3,
    required this.highlightsDescrition1,
    required this.highlightsDescrition2,
    required this.highlightsDescrition3,
    required this.phoneImage,
    required this.privacyPolicyUrl,
    required this.shortDescription,
    required this.playStoreUrl,
    this.appStoreUrl,
    required this.featureImage,
    super.key,
  });

  @override
  State<PagesWidget> createState() => _PagesWidgetState();
}

class _PagesWidgetState extends State<PagesWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Animation<double>? _fadeAnimation;

  Animation<double>? _sizeAnimation;

  ////////////////
  // AnimationController? _textAnimationController;
  Animation<Offset>? _textSlideAnimation;

  // AnimationController? _imageAnimationController;
  Animation<Offset>? _imageSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 140, right: 140),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _animationController!,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation!.value,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: _sizeAnimation!.value * 70,
                              height: _sizeAnimation!.value * 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  widget.appLogo,
                                  // width: ,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: const Text('Home')),
                              TextButton(
                                  onPressed: () {}, child: const Text('FAQ')),
                              TextButton(
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://twitter.com/StudioCupertino',
                                      ),
                                    );
                                  },
                                  child: const Text('Blog')),
                              TextButton(
                                  onPressed: () {
                                    launchUrl(
                                      Uri.parse(
                                        widget.privacyPolicyUrl,
                                      ),
                                    );
                                  },
                                  child: const Text('Privacy Policy')),
                            ]),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SlideTransition(
                            position: _textSlideAnimation!,
                            child: Text(
                              widget.shortDescription,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: _imageSlideAnimation!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  widget.appImage,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 650,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Install Now!',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 50.0),
                  ),
                  const SizedBox(height: 100),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            onPressed: () => _launchURL(widget.playStoreUrl),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'images/play_store.png',
                                width: 120,
                                // height: 40,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/iosinstallation',
                                arguments: {
                                  'appName': widget.appName,
                                  'appIcon': widget.appLogo,
                                  'appDownloadUrl': widget.appDownloadUrl,
                                },
                              );
                            },
                            // onPressed: () => _launchURL(widget.appStoreUrl),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'images/app_store.png',
                                width: 120,
                                // height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Highlights',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 50.0),
                  ),
                  const SizedBox(height: 100),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                widget.phoneImage,
                                width: 200,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50.0),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 100.0),
                                _buildFeatureRow(
                                  widget.highlightsIcon1,
                                  widget.highlightsTitle1,
                                  widget.highlightsDescrition1,
                                ),
                                const SizedBox(height: 50.0),
                                _buildFeatureRow(
                                  widget.highlightsIcon2,
                                  widget.highlightsTitle2,
                                  widget.highlightsDescrition2,
                                ),
                                const SizedBox(height: 50.0),
                                _buildFeatureRow(
                                  widget.highlightsIcon3,
                                  widget.highlightsTitle3,
                                  widget.highlightsDescrition3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Text(
                    'Sleek Interface',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle
                        .copyWith(fontSize: 50.0),
                  ),
                  const SizedBox(height: 100.0),
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(widget.featureImage,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData iconData, String title, String description) {
    return Row(
      children: [
        Icon(iconData, size: 24.0, color: Colors.black),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(description),
          ],
        ),
      ],
    );
  }
}
