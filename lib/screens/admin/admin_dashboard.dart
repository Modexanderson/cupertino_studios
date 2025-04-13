import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../app.dart';
import '../../main.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';
import 'app_management.dart';
import 'content_editor.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;
  String _adminName = '';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadAdminInfo();
  }

  Future<void> _loadAdminInfo() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userModel = await authService.getCurrentUserModel();

    if (userModel != null && mounted) {
      setState(() {
        _adminName = userModel.displayName;
      });
    }
  }

  Future<void> _signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of admin panel sections
    final List<Widget> _sections = [
      const AppManagementScreen(),
      const ContentEditorScreen(),
    ];

    final bool isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                App.updateTheme(context);
                _isDarkMode = !_isDarkMode;
              });
              // Here you would implement theme toggling with your AppTheme
            },
            tooltip:
                _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          TextButton.icon(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: isSmallScreen ? _buildDrawer() : null,
      body: Row(
        children: [
          // Side navigation for larger screens
          if (!isSmallScreen) _buildSideNavigation(),

          // Main content area
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: _sections[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      elevation: 2,
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildNavigationItems(),
        ),
      ),
    );
  }

  Widget _buildSideNavigation() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        width: 250,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          children: _buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems() {
    return [
      DrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.admin_panel_settings,
                size: 30,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Welcome, $_adminName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      _buildNavItem(
        title: 'App Management',
        icon: Icons.apps,
        index: 0,
      ),
      _buildNavItem(
        title: 'Website Content',
        icon: Icons.edit,
        index: 1,
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.dashboard_customize),
        title: const Text('Admin Dashboard'),
        subtitle: const Text('You are here'),
        selected: true,
        selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
        enabled: false,
      ),
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('View Website'),
        onTap: () {
          context.go('/');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.help_outline),
        title: const Text('Help & Support'),
        onTap: () {
          // Navigate to help page or show help dialog
        },
      ),
    ];
  }

  Widget _buildNavItem({
    required String title,
    required IconData icon,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          // Close drawer if it's open
          if (MediaQuery.of(context).size.width < 900) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
