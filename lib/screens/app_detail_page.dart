import 'dart:ui';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/firebase_service.dart';
import '../models/app_model.dart';
import '../utils/constants.dart';
import '../utils/responsive_layout.dart';
import '../widgets/animated_section.dart';
import '../theme/app_theme.dart';
import '../widgets/horizontal_scrolling_list.dart';

class AppDetailPage extends StatefulWidget {
  final String appId;
  final Function toggleTheme;

  const AppDetailPage({
    super.key,
    required this.appId,
    required this.toggleTheme,
  });

  @override
  State<AppDetailPage> createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  bool _isLoading = true;
  AppModel? _app;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadAppData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadAppData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final firebaseService =
          Provider.of<FirebaseService>(context, listen: false);
      final app = await firebaseService.getAppById(widget.appId);

      setState(() {
        _app = app;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading app data: $e');

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (url.isEmpty) return;

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  void _downloadApp(String url) {
    if (url.isEmpty) return;

    // Use JavaScript to trigger the download
    js.context.callMethod('eval', [
      '''
      const link = document.createElement('a');
      link.href = '$url';
      link.download = '${_app?.name ?? 'app'}.apk';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      '''
    ]);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download started')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _app == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('App not found'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => context.go('/'),
                        child: const Text('Go Home'),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // App Bar
                    _buildAppBar(isDark),

                    // App Header
                    SliverToBoxAdapter(
                      child: _buildAppHeader(isDark),
                    ),

                    // App Screenshots
                    SliverToBoxAdapter(
                      child: AnimatedSection(
                        child: _buildScreenshotsSection(isDark),
                      ),
                    ),

                    // App Platforms
                    SliverToBoxAdapter(
                      child: AnimatedSection(
                        child: _buildPlatformsSection(isDark),
                      ),
                    ),

                    // App Details
                    SliverToBoxAdapter(
                      child: AnimatedSection(
                        child: _buildAppDetailsSection(isDark),
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
        titlePadding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        title: Text(
          _app?.name ?? 'App Details',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      actions: [
        // Home Button
        IconButton(
          icon: Icon(
            Icons.home,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.go('/'),
          tooltip: 'Home',
        ),

        // Theme Toggle Button
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => widget.toggleTheme(),
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
        ),
      ],
    );
  }

  Widget _buildAppHeader(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
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
        mobile: _buildAppHeaderMobile(isDark),
        tablet: _buildAppHeaderDesktop(isDark),
        desktop: _buildAppHeaderDesktop(isDark),
      ),
    );
  }

  Widget _buildAppHeaderMobile(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // App Icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              imageUrl: _app!.iconUrl,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // App Info
        Text(
          _app!.name,
          style: AppTheme.headingLarge(isDark: isDark).copyWith(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Cupertino Studios',
          style: AppTheme.titleMedium(isDark: isDark).copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // App Meta Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMetaInfoItem(
              icon: Icons.download,
              value: '${_app!.downloadsCount}+',
              label: 'Downloads',
              isDark: isDark,
            ),
            const SizedBox(width: 24),
            _buildMetaInfoItem(
              icon: Icons.star,
              value: _app!.rating,
              label: 'Rating',
              isDark: isDark,
            ),
            const SizedBox(width: 24),
            _buildMetaInfoItem(
              icon: Icons.category,
              value: _app!.category,
              label: 'Category',
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Download Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_app!.downloadUrls.containsKey('Android')) {
                _downloadApp(_app!.downloadUrls['Android']!);
              } else if (_app!.downloadUrls.isNotEmpty) {
                _downloadApp(_app!.downloadUrls.values.first);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No download link available')),
                );
              }
            },
            icon: const Icon(Icons.download),
            label: const Text('Download App'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // App Short Description
        if (_app!.shortDescription.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _app!.shortDescription,
              style: AppTheme.bodyMedium(isDark: isDark).copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAppHeaderDesktop(bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Icon
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: CachedNetworkImage(
              imageUrl: _app!.iconUrl,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 40),

        // App Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _app!.name,
                style: AppTheme.headingLarge(isDark: isDark).copyWith(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cupertino Studios',
                style: AppTheme.titleMedium(isDark: isDark).copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),

              // App Meta Info
              Row(
                children: [
                  _buildMetaInfoItem(
                    icon: Icons.download,
                    value: '${_app!.downloadsCount}+',
                    label: 'Downloads',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 32),
                  _buildMetaInfoItem(
                    icon: Icons.star,
                    value: _app!.rating,
                    label: 'Rating',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 32),
                  _buildMetaInfoItem(
                    icon: Icons.category,
                    value: _app!.category,
                    label: 'Category',
                    isDark: isDark,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (_app!.shortDescription.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _app!.shortDescription,
                    style: AppTheme.bodyLarge(isDark: isDark).copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Download Button
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_app!.downloadUrls.containsKey('Android')) {
                        _downloadApp(_app!.downloadUrls['Android']!);
                      } else if (_app!.downloadUrls.isNotEmpty) {
                        _downloadApp(_app!.downloadUrls.values.first);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No download link available')),
                        );
                      }
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download App'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (_app!.storeUrls.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_app!.storeUrls.containsKey('Android')) {
                          _launchURL(_app!.storeUrls['Android']!);
                        } else {
                          _launchURL(_app!.storeUrls.values.first);
                        }
                      },
                      icon: const Icon(Icons.store),
                      label: const Text('View in Store'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetaInfoItem({
    required IconData icon,
    required String value,
    required String label,
    required bool isDark,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.titleMedium(isDark: isDark).copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.bodySmall(isDark: isDark).copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildScreenshotsSection(bool isDark) {
    // Combine feature graphic and screenshots
    List<String> allImages = [];

    // Add feature graphic first if it exists
    if (_app!.featureGraphicUrl.isNotEmpty) {
      allImages.add(_app!.featureGraphicUrl);
    }

    // Add all screenshots
    allImages.addAll(_app!.screenshots);

    if (allImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Images',
            style: AppTheme.headingMedium(isDark: isDark),
          ),
          const SizedBox(height: 24),
          HorizontalScrollingList(
            imageUrl: allImages,
            itemCount: allImages.length,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformsSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      color: isDark
          ? AppTheme.getThemeColor(
              context, Colors.grey.shade100, Colors.grey.shade900)
          : Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Platforms',
            style: AppTheme.headingMedium(isDark: isDark),
          ),
          const SizedBox(height: 16),
          Text(
            'This app is available for all your devices',
            style: AppTheme.bodyMedium(isDark: isDark),
          ),
          const SizedBox(height: 24),
          ResponsiveLayout(
            mobile: _buildPlatformsGridMobile(isDark),
            tablet: _buildPlatformsGridDesktop(isDark),
            desktop: _buildPlatformsGridDesktop(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformsGridMobile(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _app!.platforms.length,
      itemBuilder: (context, index) {
        final platform = _app!.platforms[index];
        final hasDownloadUrl = _app!.downloadUrls.containsKey(platform);

        return _buildPlatformCard(
          platform: platform,
          hasDownloadUrl: hasDownloadUrl,
          isDark: isDark,
        );
      },
    );
  }

  Widget _buildPlatformsGridDesktop(bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _app!.platforms.length,
      itemBuilder: (context, index) {
        final platform = _app!.platforms[index];
        final hasDownloadUrl = _app!.downloadUrls.containsKey(platform);

        return _buildPlatformCard(
          platform: platform,
          hasDownloadUrl: hasDownloadUrl,
          isDark: isDark,
        );
      },
    );
  }

  Widget _buildPlatformCard({
    required String platform,
    required bool hasDownloadUrl,
    required bool isDark,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: hasDownloadUrl
            ? () => _downloadApp(_app!.downloadUrls[platform]!)
            : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getPlatformIcon(platform),
              const SizedBox(height: 16),
              Text(
                platform,
                style: AppTheme.titleMedium(isDark: isDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                hasDownloadUrl ? 'Available' : 'Coming Soon',
                style: AppTheme.bodySmall(isDark: isDark).copyWith(
                  color: hasDownloadUrl
                      ? kAccentColor
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppDetailsSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      color: isDark
          ? AppTheme.getThemeColor(context, Colors.white, Colors.black)
          : Colors.white,
      child: ResponsiveLayout(
        mobile: _buildAppDetailsMobile(isDark),
        tablet: _buildAppDetailsDesktop(isDark),
        desktop: _buildAppDetailsDesktop(isDark),
      ),
    );
  }

  Widget _buildAppDetailsMobile(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About this app
        Text(
          'About this app',
          style: AppTheme.headingMedium(isDark: isDark),
        ),
        const SizedBox(height: 16),
        _buildDetailCard(
          content: _app!.description,
          isDark: isDark,
        ),
        const SizedBox(height: 40),

        // Features
        if (_app!.features.isNotEmpty) ...[
          Text(
            'Features',
            style: AppTheme.headingMedium(isDark: isDark),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _app!.features.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: kAccentColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _app!.features[index],
                        style: AppTheme.bodyMedium(isDark: isDark),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],

        // What's New
        if (_app!.whatsNew.isNotEmpty) ...[
          Text(
            "What's New",
            style: AppTheme.headingMedium(isDark: isDark),
          ),
          const SizedBox(height: 16),
          _buildDetailCard(
            content: _app!.whatsNew,
            isDark: isDark,
          ),
          const SizedBox(height: 40),
        ],

        // Data Safety
        if (_app!.dataSafety.isNotEmpty) ...[
          Text(
            'Data Safety',
            style: AppTheme.headingMedium(isDark: isDark),
          ),
          const SizedBox(height: 16),
          _buildDetailCard(
            content: _app!.dataSafety,
            isDark: isDark,
          ),
        ],
      ],
    );
  }

  Widget _buildAppDetailsDesktop(bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - About and Features
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About this app',
                style: AppTheme.headingMedium(isDark: isDark),
              ),
              const SizedBox(height: 16),
              _buildDetailCard(
                content: _app!.description,
                isDark: isDark,
              ),
              const SizedBox(height: 40),
              if (_app!.features.isNotEmpty) ...[
                Text(
                  'Features',
                  style: AppTheme.headingMedium(isDark: isDark),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _app!.features.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: kAccentColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _app!.features[index],
                              style: AppTheme.bodyMedium(isDark: isDark),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 40),

        // Right column - What's New and Data Safety
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_app!.whatsNew.isNotEmpty) ...[
                Text(
                  "What's New",
                  style: AppTheme.headingMedium(isDark: isDark),
                ),
                const SizedBox(height: 16),
                _buildDetailCard(
                  content: _app!.whatsNew,
                  isDark: isDark,
                ),
                const SizedBox(height: 40),
              ],

              if (_app!.dataSafety.isNotEmpty) ...[
                Text(
                  'Data Safety',
                  style: AppTheme.headingMedium(isDark: isDark),
                ),
                const SizedBox(height: 16),
                _buildDetailCard(
                  content: _app!.dataSafety,
                  isDark: isDark,
                ),
                const SizedBox(height: 40),
              ],

              // Store links
              if (_app!.storeUrls.isNotEmpty) ...[
                Text(
                  'Available On',
                  style: AppTheme.headingMedium(isDark: isDark),
                ),
                const SizedBox(height: 16),
                Column(
                  children: _app!.storeUrls.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: _getStoreIcon(entry.key),
                          title: Text(
                            _getStoreName(entry.key),
                            style:
                                AppTheme.titleMedium(isDark: isDark).copyWith(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(Icons.launch),
                          onTap: () => _launchURL(entry.value),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required String content,
    required bool isDark,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          content,
          style: AppTheme.bodyMedium(isDark: isDark),
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
        ],
      ),
    );
  }

  Widget _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/android.png?alt=media&token=53a4be3c-8ea0-4187-a49a-a8587b8bdc9f',
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.android, size: 60),
        );
      case 'ios':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/apple.png?alt=media&token=5fe90103-f05c-4fab-8991-8c5f9c1a082d',
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.apple, size: 60),
        );
      case 'windows':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/windows.png?alt=media&token=68325716-9094-4bfc-b121-67b336ab1460',
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.desktop_windows, size: 60),
        );
      case 'macos':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/macOS.png?alt=media&token=10672558-6062-41a5-bc51-83d348c42e83',
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.desktop_mac, size: 60),
        );
      case 'linux':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/linux.png?alt=media&token=5d05044f-a263-48e0-8165-38fa9123593a',
          width: 60,
          height: 60,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.computer, size: 60),
        );
      case 'web':
        return const Icon(Icons.web, size: 60);
      default:
        return const Icon(Icons.devices, size: 60);
    }
  }

  Widget _getStoreIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/play_store.png?alt=media&token=a44e3ad9-2b2c-455e-bcae-229f8fbf60a7',
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.android, size: 40),
        );
      case 'ios':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/app_store.png?alt=media&token=107d5501-cbe6-4d42-b417-8367f9760d3c',
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.apple, size: 40),
        );
      case 'huawei':
        return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/huawei-appgallery.png?alt=media&token=5a1ca6e0-cff6-4a49-9cbd-2edc20a06aab',
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.store, size: 40),
        );
      default:
        return const Icon(Icons.store, size: 40);
    }
  }

  String _getStoreName(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return 'Google Play Store';
      case 'ios':
        return 'Apple App Store';
      case 'huawei':
        return 'Huawei AppGallery';
      default:
        return platform;
    }
  }
}
