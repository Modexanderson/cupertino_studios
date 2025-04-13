// lib/widgets/navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebsiteNavigationBar extends StatelessWidget {
  final String logoUrl;
  final String title;
  // final bool isAdmin;
  final VoidCallback onAdminTap;

  const WebsiteNavigationBar({
    super.key,
    required this.logoUrl,
    required this.title,
    // required this.isAdmin,
    required this.onAdminTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Logo
              Image.asset(
                logoUrl,
                width: constraints.maxWidth < 700 ? 40 : 60,
                fit: BoxFit.contain,
              ),

              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 700 ? 16 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Support and Admin buttons
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/support');
                    },
                    child: const Text('Support'),
                  ),
                  // if (isAdmin)
                  TextButton(
                    onPressed: onAdminTap,
                    child: const Text('Admin'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
