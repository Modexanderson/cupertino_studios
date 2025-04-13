import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../services/firebase_service.dart';
import '../models/app_model.dart';
import '../widgets/app_card.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_layout.dart';

class AllAppsPage extends StatefulWidget {
  const AllAppsPage({super.key});

  @override
  State<AllAppsPage> createState() => _AllAppsPageState();
}

class _AllAppsPageState extends State<AllAppsPage> {
  bool _isLoading = true;
  List<AppModel> _apps = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  Future<void> _loadApps() async {
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load all apps
      final apps = await firebaseService.getApps();

      if (mounted) {
        setState(() {
          _apps = apps;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading apps: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load apps. Please try again later.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Apps'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          // Theme Toggle Button
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => context
                .findAncestorStateOfType<_AllAppsPageState>()
                ?.build(context),
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: AppTheme.bodyLarge(isDark: isDark),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadApps,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _apps.isEmpty
                  ? Center(
                      child: Text(
                        'No apps available at the moment.',
                        style: AppTheme.bodyLarge(isDark: isDark),
                      ),
                    )
                  : _buildAppsList(isDark),
    );
  }

  Widget _buildAppsList(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDark ? Colors.black : Colors.grey.shade100,
      child: ResponsiveLayout(
        mobile: _buildAppsMobile(isDark),
        tablet: _buildAppsTabletDesktop(isDark),
        desktop: _buildAppsTabletDesktop(isDark),
      ),
    );
  }

  Widget _buildAppsMobile(bool isDark) {
    return ListView.builder(
      itemCount: _apps.length,
      itemBuilder: (context, index) {
        final app = _apps[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppCard(
            appName: app.name,
            platform: app.platforms.join(', '),
            iconUrl: app.iconUrl,
            description: app.shortDescription,
            onPressed: () {
              context.go('/app/${app.id}');
            },
          ),
        );
      },
    );
  }

  Widget _buildAppsTabletDesktop(bool isDark) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _apps.length,
      itemBuilder: (context, index) {
        final app = _apps[index];
        return AppCard(
          appName: app.name,
          platform: app.platforms.join(', '),
          iconUrl: app.iconUrl,
          description: app.shortDescription,
          onPressed: () {
            context.go('/app/${app.id}');
          },
        );
      },
    );
  }
}
