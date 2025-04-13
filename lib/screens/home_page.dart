import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app.dart';
import '../services/firebase_service.dart';
import '../services/auth_service.dart';
import '../models/app_model.dart';
import '../models/website_content_model.dart';
import '../utils/constants.dart';
import '../utils/responsive_layout.dart';
import '../widgets/app_card.dart';
import '../widgets/pricing_card.dart';
import '../widgets/faq_item.dart';
import '../widgets/animated_section.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  WebsiteContentModel? _websiteContent;
  List<AppModel> _apps = [];
  bool _isAdmin = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      // Load website content
      final websiteContent = await firebaseService.getWebsiteContent();

      // Load apps
      final apps = await firebaseService.getApps();

      // Check if current user is admin
      final isAdmin = await authService.isAdmin();

      if (mounted) {
        setState(() {
          _websiteContent = websiteContent;
          _apps = apps;
          _isAdmin = isAdmin;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _sendEmail() async {
    final contactEmail =
        _websiteContent?.contactEmail ?? 'cupertinostudios@gmail.com';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: contactEmail,
      queryParameters: {
        'subject': 'Inquiry from Website',
        'body': 'Hello Cupertino Studios,\n\n',
      },
    );

    try {
      await launchUrl(Uri.parse(emailUri.toString()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }

  void _navigateToAdminPanel() {
    context.go('/admin/login');
  }

  void _scrollToSection(String section) {
    // Create a map to store section keys
    final Map<String, double> sectionOffsets = {
      'features': 600, // Approximate offset for features section
      'apps': 1200, // Approximate offset for apps section
      'pricing': 1800, // Approximate offset for pricing section
      'faq': 2400, // Approximate offset for FAQ section
      'contact': 3000, // Approximate offset for contact section
    };

    // Check if the section exists in our map
    if (sectionOffsets.containsKey(section)) {
      _scrollController.animateTo(
        sectionOffsets[section]!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App Bar
                _buildAppBar(isDark),

                // Hero Section
                SliverToBoxAdapter(
                  child: _buildHeroSection(isDark),
                ),

                // Features Section
                SliverToBoxAdapter(
                  child: AnimatedSection(
                    child: _buildFeaturesSection(isDark),
                  ),
                ),

                // Apps Showcase
                SliverToBoxAdapter(
                  child: AnimatedSection(
                    child: _buildAppsShowcase(isDark),
                  ),
                ),

                // Pricing Section
                SliverToBoxAdapter(
                  child: AnimatedSection(
                    child: _buildPricingSection(isDark),
                  ),
                ),

                // FAQ Section
                SliverToBoxAdapter(
                  child: AnimatedSection(
                    child: _buildFAQSection(isDark),
                  ),
                ),

                // Contact Section
                SliverToBoxAdapter(
                  child: AnimatedSection(
                    child: _buildContactSection(isDark),
                  ),
                ),

                // Footer
                SliverToBoxAdapter(
                  child: _buildFooter(isDark),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
        tooltip: 'Back to top',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  Widget _buildAppBar(bool isDark) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 70,
      backgroundColor: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      elevation: 4,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo-no-background.png',
              height: 30,
            ),
            const SizedBox(width: 12),
            Text(
              'Cupertino Studios',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Navigation Links (only visible on larger screens)
        ResponsiveLayout(
          mobile: Container(),
          tablet: _buildNavLinks(isDark),
          desktop: _buildNavLinks(isDark),
        ),

        // Theme Toggle Button
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => App.updateTheme(context),
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
        ),

        // Admin Button (if user is admin)
        // if (_isAdmin)
        IconButton(
          icon: Icon(
            Icons.admin_panel_settings,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: _navigateToAdminPanel,
          tooltip: 'Admin Panel',
        ),

        // Menu Button (only visible on mobile)
        ResponsiveLayout(
          mobile: IconButton(
            icon: Icon(
              Icons.menu,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              // Show drawer or bottom sheet with navigation options
              Scaffold.of(context).openEndDrawer();
            },
          ),
          tablet: Container(),
          desktop: Container(),
        ),
      ],
    );
  }

  Widget _buildNavLinks(bool isDark) {
    return Row(
      children: [
        TextButton(
          onPressed: () => _scrollToSection('features'),
          child: Text(
            'Features',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _scrollToSection('apps'),
          child: Text(
            'Our Apps',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _scrollToSection('pricing'),
          child: Text(
            'Pricing',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _scrollToSection('faq'),
          child: Text(
            'FAQ',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _scrollToSection('contact'),
          child: Text(
            'Contact',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Colors.blueGrey.shade900, Colors.black]
              : [Colors.blue.shade100, Colors.blue.shade400],
        ),
      ),
      child: ResponsiveLayout(
        mobile: _buildHeroMobile(isDark),
        tablet: _buildHeroDesktop(isDark),
        desktop: _buildHeroDesktop(isDark),
      ),
    );
  }

  Widget _buildHeroMobile(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _websiteContent?.welcomeTitle ?? 'Welcome to Cupertino Studios',
          style: AppTheme.headingLarge(isDark: isDark).copyWith(
            color: Colors.white,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          _websiteContent?.welcomeMessage ??
              'We build beautiful and powerful mobile apps.',
          style: AppTheme.bodyLarge(isDark: isDark).copyWith(
            color: Colors.white.withOpacity(0.9),
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _sendEmail,
          style: AppTheme.primaryButtonStyle().copyWith(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          child: const Text('Get Started', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 40),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: _websiteContent?.heroImageUrl ?? '',
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, size: 80),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroDesktop(bool isDark) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _websiteContent?.welcomeTitle ?? 'Welcome to Cupertino Studios',
                style: AppTheme.headingLarge(isDark: isDark).copyWith(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _websiteContent?.welcomeMessage ??
                    'We build beautiful and powerful mobile apps.',
                style: AppTheme.bodyLarge(isDark: isDark).copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _sendEmail,
                    style: AppTheme.primaryButtonStyle().copyWith(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                    ),
                    child: const Text('Get Started',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/support'),
                    style:
                        AppTheme.secondaryButtonStyle(isDark: isDark).copyWith(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: const Text('Learn More',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: _websiteContent?.heroImageUrl ?? '',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, size: 80),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isDark) {
    final features = [
      {
        'icon': Icons.design_services,
        'title': 'Custom Design',
        'description':
            'Beautiful, user-friendly interfaces tailored to your brand.',
      },
      {
        'icon': Icons.devices,
        'title': 'Cross-Platform',
        'description':
            'Apps that work seamlessly on iOS, Android, and the web.',
      },
      {
        'icon': Icons.speed,
        'title': 'Performance',
        'description': 'Optimized for speed and responsiveness on all devices.',
      },
      {
        'icon': Icons.security,
        'title': 'Security',
        'description': 'Built with the latest security best practices.',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Why Choose Us',
            style: AppTheme.headingMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'We deliver exceptional app experiences with cutting-edge technology',
            style: AppTheme.bodyMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ResponsiveLayout(
            mobile: _buildFeaturesMobile(features, isDark),
            tablet: _buildFeaturesDesktop(features, isDark),
            desktop: _buildFeaturesDesktop(features, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesMobile(
      List<Map<String, dynamic>> features, bool isDark) {
    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _buildFeatureCard(
            icon: feature['icon'],
            title: feature['title'],
            description: feature['description'],
            isDark: isDark,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeaturesDesktop(
      List<Map<String, dynamic>> features, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildFeatureCard(
              icon: feature['icon'],
              title: feature['title'],
              description: feature['description'],
              isDark: isDark,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isDark,
  }) {
    return Card(
      elevation: 0,
      color: isDark
          ? AppTheme.getThemeColor(
              context, Colors.grey.shade100, Colors.grey.shade900)
          : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: kPrimaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTheme.titleMedium(isDark: isDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTheme.bodyMedium(isDark: isDark),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppsShowcase(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: isDark
          ? AppTheme.getThemeColor(
              context, Colors.grey.shade100, Colors.black.withOpacity(0.3))
          : Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our Apps',
            style: AppTheme.headingMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Discover our collection of innovative applications',
            style: AppTheme.bodyMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          _apps.isEmpty
              ? Center(
                  child: Text(
                    'No apps available at the moment.',
                    style: AppTheme.bodyMedium(isDark: isDark),
                  ),
                )
              : ResponsiveLayout(
                  mobile: _buildAppsMobile(isDark),
                  tablet: _buildAppsDesktop(isDark),
                  desktop: _buildAppsDesktop(isDark),
                ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              context.go('/apps'); // Navigate to the all apps page
            },
            style: AppTheme.secondaryButtonStyle(isDark: isDark),
            child: const Text('View All Apps'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppsMobile(bool isDark) {
    return Column(
      children: _apps.take(3).map((app) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppCard(
            appName: app.name,
            platform: app.platforms.join(', '),
            onPressed: () {
              context.go('/app/${app.id}');
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAppsDesktop(bool isDark) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: _apps.take(6).map((app) {
        return SizedBox(
          width: 300,
          child: AppCard(
            appName: app.name,
            platform: app.platforms.join(', '),
            onPressed: () {
              context.go('/app/${app.id}');
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPricingSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our Pricing',
            style: AppTheme.headingMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Transparent pricing plans for app development services',
            style: AppTheme.bodyMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ResponsiveLayout(
            mobile: _buildPricingMobile(isDark),
            tablet: _buildPricingDesktop(isDark),
            desktop: _buildPricingDesktop(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingMobile(bool isDark) {
    final pricingPackages = _websiteContent?.pricingPackages ?? [];

    return Column(
      children: pricingPackages.map((package) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PricingPackageCard(
            title: package.title,
            description: package.description,
            price: package.price,
            features: package.features,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPricingDesktop(bool isDark) {
    final pricingPackages = _websiteContent?.pricingPackages ?? [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: pricingPackages.map((package) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PricingPackageCard(
              title: package.title,
              description: package.description,
              price: package.price,
              features: package.features,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFAQSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: isDark
          ? AppTheme.getThemeColor(
              context, Colors.grey.shade100, Colors.black.withOpacity(0.3))
          : Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Frequently Asked Questions',
            style: AppTheme.headingMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Find answers to common questions about our services',
            style: AppTheme.bodyMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: (_websiteContent?.faqs ?? []).map((faq) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FAQItemWidget(
                    question: faq.question,
                    answer: faq.answer,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get in Touch',
            style: AppTheme.headingMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Have a project in mind? Contact us today!',
            style: AppTheme.bodyMedium(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _sendEmail,
                          icon: const Icon(Icons.email),
                          label: const Text('Email Us'),
                          style: AppTheme.primaryButtonStyle(),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.go('/support'),
                          icon: const Icon(Icons.support_agent),
                          label: const Text('Support'),
                          style: AppTheme.primaryButtonStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Follow Us',
                      style: AppTheme.titleMedium(isDark: isDark),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          onPressed: () async {
                            final url = 'https://facebook.com/cupertinostudios';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Could not open Facebook page')),
                              );
                            }
                          },
                          tooltip: 'Facebook',
                          color: kPrimaryColor,
                          iconSize: 32,
                        ),
                        IconButton(
                          icon: const Icon(Icons.social_distance),
                          onPressed: () async {
                            final url = 'https://twitter.com/cupertinostudios';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Could not open Twitter page')),
                              );
                            }
                          },
                          tooltip: 'Twitter',
                          color: kPrimaryColor,
                          iconSize: 32,
                        ),
                        IconButton(
                          icon: const Icon(Icons.linked_camera),
                          onPressed: () async {
                            final url =
                                'https://linkedin.com/company/cupertinostudios';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Could not open LinkedIn page')),
                              );
                            }
                          },
                          tooltip: 'LinkedIn',
                          color: kPrimaryColor,
                          iconSize: 32,
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () async {
                            const phone = '+2348173227654';
                            final url = 'tel:$phone';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Could not open phone dialer')),
                              );
                            }
                          },
                          tooltip: 'Phone',
                          color: kPrimaryColor,
                          iconSize: 32,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.grey.shade800, Colors.black)
          : Colors.grey.shade800,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo-no-background.png',
                height: 40,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Text(
                'Cupertino Studios',
                style: AppTheme.titleLarge(isDark: true).copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            _websiteContent?.footerText ??
                '© 2023 Cupertino Studios. All rights reserved.',
            style: AppTheme.bodyMedium(isDark: true).copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final url = 'https://cupertinostudios.com/privacy-policy';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Could not open Privacy Policy page')),
                    );
                  }
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final url = 'https://cupertinostudios.com/terms-of-service';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Could not open Terms of Service page')),
                    );
                  }
                },
                child: Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
