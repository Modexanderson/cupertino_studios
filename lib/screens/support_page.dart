import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../services/firebase_service.dart';
import '../models/website_content_model.dart';
import '../utils/constants.dart';
import '../utils/responsive_layout.dart';
import '../widgets/animated_section.dart';
import '../widgets/faq_item.dart';
import '../theme/app_theme.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({
    super.key,
  });

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool _isLoading = true;
  WebsiteContentModel? _websiteContent;
  bool _isAdmin = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final firebaseService =
          Provider.of<FirebaseService>(context, listen: false);
      final websiteContent = await firebaseService.getWebsiteContent();

      setState(() {
        _websiteContent = websiteContent;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      try {
        final contactEmail =
            _websiteContent?.contactEmail ?? 'cupertinostudios@gmail.com';

        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: contactEmail,
          queryParameters: {
            'subject': 'Support Request from ${_nameController.text}',
            'body': 'Name: ${_nameController.text}\n'
                'Email: ${_emailController.text}\n'
                'WhatsApp: ${_whatsappController.text}\n\n'
                '${_messageController.text}',
          },
        );

        if (await canLaunchUrl(Uri.parse(emailUri.toString()))) {
          await launchUrl(Uri.parse(emailUri.toString()));

          // Clear form
          _nameController.clear();
          _emailController.clear();
          _whatsappController.clear();
          _messageController.clear();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Support request sent successfully')),
            );
          }
        } else {
          throw 'Could not launch email';
        }
      } catch (e) {
        print('Error sending email: $e');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send support request')),
          );
        }
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _navigateToAdminPanel() {
    context.go('/admin/login');
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

                // Content
                SliverToBoxAdapter(
                  child: ResponsiveLayout(
                    mobile: _buildMobileLayout(isDark),
                    tablet: _buildDesktopLayout(isDark),
                    desktop: _buildDesktopLayout(isDark),
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
        // Navigation Link to Home
        TextButton(
          onPressed: () => context.go('/'),
          child: Text(
            'Home',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
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
        if (_isAdmin)
          IconButton(
            icon: Icon(
              Icons.admin_panel_settings,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: _navigateToAdminPanel,
            tooltip: 'Admin Panel',
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
      child: Column(
        children: [
          Text(
            'Support & Help Center',
            style: AppTheme.headingLarge(isDark: isDark).copyWith(
              color: Colors.white,
              fontSize: 36,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              'If you have any questions, feedback, or encounter any issues with our apps, we\'re here to help.',
              style: AppTheme.bodyLarge(isDark: isDark).copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final contactEmail = _websiteContent?.contactEmail ??
                      'cupertinostudios@gmail.com';
                  final url = 'mailto:$contactEmail';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                icon: const Icon(Icons.email),
                label: const Text('Email Support'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  const phone = '+2348173227654';
                  final url = 'tel:$phone';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  }
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call Us'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSection(
            child: _buildContactForm(isDark),
          ),
          const SizedBox(height: 40),
          AnimatedSection(
            child: _buildFAQSection(isDark),
          ),
          const SizedBox(height: 40),
          AnimatedSection(
            child: _buildSupportResources(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AnimatedSection(
                  child: _buildContactForm(isDark),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                flex: 2,
                child: AnimatedSection(
                  child: _buildSupportResources(isDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          AnimatedSection(
            child: _buildFAQSection(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Support',
              style: AppTheme.titleLarge(isDark: isDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill out the form below to send us a message',
              style: AppTheme.bodyMedium(isDark: isDark),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: AppTheme.getInputDecoration(
                      context,
                      labelText: 'Your Name',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: AppTheme.getInputDecoration(
                      context,
                      labelText: 'Your Email',
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _whatsappController,
                    decoration: AppTheme.getInputDecoration(
                      context,
                      labelText: 'Your WhatsApp Number',
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: AppTheme.getInputDecoration(
                      context,
                      labelText: 'Your Message',
                      hintText: 'Describe your issue or feedback...',
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSending ? null : _sendEmail,
                      style: AppTheme.primaryButtonStyle(),
                      child: _isSending
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Send Message',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: AppTheme.titleLarge(isDark: isDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers to common questions about our services',
              style: AppTheme.bodyMedium(isDark: isDark),
            ),
            const SizedBox(height: 24),
            // Display FAQs from website content or defaults if none available
            ...(_websiteContent?.faqs.isEmpty ?? true
                ? [
                    FAQItemWidget(
                      question: 'How do I reset my password?',
                      answer:
                          'You can reset your password by clicking on the "reset password" text in the login page of the app.',
                    ),
                    const SizedBox(height: 16),
                    FAQItemWidget(
                      question: 'Why am I unable to log in?',
                      answer:
                          'Make sure you are using the correct email address and password. If you are still unable to log in, please contact support for further assistance.',
                    ),
                    const SizedBox(height: 16),
                    FAQItemWidget(
                      question: 'How can I update the app?',
                      answer:
                          'You can update the app from the App Store or Google Play Store, depending on your device.',
                    ),
                    const SizedBox(height: 16),
                    FAQItemWidget(
                      question: 'Is my data secure with your apps?',
                      answer:
                          'Yes, we take data security seriously. All data is encrypted and stored securely. We never share your personal information with third parties without your consent.',
                    ),
                  ]
                : _websiteContent!.faqs.map((faq) {
                    return Column(
                      children: [
                        FAQItemWidget(
                          question: faq.question,
                          answer: faq.answer,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportResources(bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support Resources',
              style: AppTheme.titleLarge(isDark: isDark),
            ),
            const SizedBox(height: 16),
            _buildResourceItem(
              isDark: isDark,
              icon: Icons.article,
              title: 'Documentation',
              description:
                  'Browse our knowledge base for detailed guides and tutorials.',
              onTap: () {
                // Link to documentation
              },
            ),
            const Divider(),
            _buildResourceItem(
              isDark: isDark,
              icon: Icons.videocam,
              title: 'Video Tutorials',
              description: 'Watch video demonstrations of our app features.',
              onTap: () {
                // Link to video tutorials
              },
            ),
            const Divider(),
            _buildResourceItem(
              isDark: isDark,
              icon: Icons.forum,
              title: 'Community Forum',
              description: 'Join discussions and get help from other users.',
              onTap: () {
                // Link to community forum
              },
            ),
            const Divider(),
            _buildResourceItem(
              isDark: isDark,
              icon: Icons.chat,
              title: 'Live Chat',
              description:
                  'Chat with our support team in real-time during business hours.',
              onTap: () async {
                const whatsapp = '+2348173227654';
                final url = 'https://wa.me/$whatsapp';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem({
    required bool isDark,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: kPrimaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.titleMedium(isDark: isDark).copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTheme.bodySmall(isDark: isDark),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
          ],
        ),
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
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () async {
              const phone = '+2348173227654';
              final url = 'tel:$phone';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            icon: const Icon(Icons.phone),
            label: const Text('Call Us'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
