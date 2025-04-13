import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/admin_login.dart';
import 'screens/all_apps_page.dart';
import 'screens/app_detail_page.dart';
import 'screens/home_page.dart';
import 'screens/support_page.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  static void updateTheme(BuildContext context) {
    final _AppState state = context.findAncestorStateOfType<_AppState>()!;
    state.toggleTheme();
  }
}

class _AppState extends State<App> {
  // Default to light theme
  bool _isDarkMode = false;
  final String _themePreferenceKey = 'isDarkMode';
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _setupRouter();
  }

  void _setupRouter() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/support',
          builder: (context, state) => const SupportPage(),
        ),
        GoRoute(
          path: '/admin/login',
          builder: (context, state) => const AdminLoginPage(),
        ),
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const AdminRouteGuard(
            child: AdminDashboardPage(),
          ),
        ),
        GoRoute(
          path: '/app/:appId',
          builder: (context, state) {
            final appId = state.pathParameters['appId']!;
            return AppDetailPage(
              appId: appId,
              toggleTheme: toggleTheme,
            );
          },
        ),
        GoRoute(
          path: '/apps',
          builder: (context, state) => const AllAppsPage(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Page not found: ${state.uri.path}'),
        ),
      ),
    );
  }

  // Load saved theme preference
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool(_themePreferenceKey) ?? false;
    });
  }

  // Save theme preference
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDarkMode);
  }

  // Toggle between light and dark theme
  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _saveThemePreference(_isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cupertino Studios',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme(context: context),
      darkTheme: AppTheme.darkTheme(context: context),
      routerConfig: _router,
    );
  }
}

class AdminRouteGuard extends StatelessWidget {
  final Widget child;

  const AdminRouteGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FutureBuilder<bool>(
      future: () async {
        try {
          print('Checking admin status...'); // Debug print
          final isAdmin = await authService.isAdmin();
          print('Admin status: $isAdmin'); // Debug print
          return isAdmin;
        } catch (e) {
          print('Error checking admin status: $e'); // Error logging
          return false;
        }
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data != true) {
          // If not admin or error, redirect to login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/admin/login');
          });

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return child;
      },
    );
  }
}
