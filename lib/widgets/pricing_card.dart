import 'package:flutter/material.dart';

// Missing import
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';
import '../theme/app_theme.dart';

/// A card widget to display pricing package information.
///
/// This widget shows a pricing package with title, description, price, and features.
class PricingPackageCard extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final List<String> features;
  final bool isPopular;

  const PricingPackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    this.isPopular = false,
  });

  @override
  State<PricingPackageCard> createState() => _PricingPackageCardState();
}

class _PricingPackageCardState extends State<PricingPackageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0, _isHovered ? -5 : 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: _isHovered ? 8 : 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: widget.isPopular
                      ? kPrimaryColor
                      : (_isHovered
                          ? kPrimaryColor.withOpacity(0.5)
                          : Colors.transparent),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Pricing Title
                    Text(
                      widget.title,
                      style: AppTheme.titleLarge(isDark: isDark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Pricing Description
                    Text(
                      widget.description,
                      style: AppTheme.bodyMedium(isDark: isDark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Price
                    Text(
                      widget.price,
                      style: AppTheme.headingLarge(isDark: isDark).copyWith(
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Pricing Details
                    Text(
                      'Starting price per project',
                      style: AppTheme.bodySmall(isDark: isDark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Divider(
                      color: isDark ? Colors.grey[700] : Colors.grey[300],
                      thickness: 1,
                    ),
                    const SizedBox(height: 24),

                    // Features List
                    ...widget.features.map((feature) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTheme.bodyMedium(isDark: isDark),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // Contact Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Contact action
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: 'cupertinostudios@gmail.com',
                            queryParameters: {
                              'subject':
                                  'Inquiry about ${widget.title} Package',
                              'body':
                                  'Hello Cupertino Studios,\n\nI am interested in the ${widget.title} package.\n\n',
                            },
                          );

                          launchUrl(Uri.parse(emailUri.toString()));
                        },
                        style: AppTheme.primaryButtonStyle().copyWith(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                        child: const Text('Contact Us'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Popular Badge
            if (widget.isPopular)
              Positioned(
                top: -15,
                right: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
