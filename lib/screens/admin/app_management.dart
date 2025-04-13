import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import '../../services/firebase_service.dart';
import '../../models/app_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_editor_dialog.dart';

class AppManagementScreen extends StatefulWidget {
  const AppManagementScreen({super.key});

  @override
  State<AppManagementScreen> createState() => _AppManagementScreenState();
}

class _AppManagementScreenState extends State<AppManagementScreen> {
  bool _isLoading = true;
  List<AppModel> _apps = [];
  String _searchQuery = "";
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadApps() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final firebaseService =
          Provider.of<FirebaseService>(context, listen: false);
      final apps = await firebaseService.getApps();

      setState(() {
        _apps = apps;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading apps: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteApp(AppModel app) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text(
            'Are you sure you want to delete ${app.name}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _isLoading = true;
      });

      try {
        final firebaseService =
            Provider.of<FirebaseService>(context, listen: false);

        // Delete app data
        await firebaseService.deleteApp(app.id);

        // Delete associated images
        await _deleteAppImages(app);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${app.name} has been deleted'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );

        // Refresh app list
        await _loadApps();
      } catch (e) {
        print('Error deleting app: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete app'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteAppImages(AppModel app) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;

      // Delete icon
      if (app.iconUrl.isNotEmpty) {
        await storage.refFromURL(app.iconUrl).delete();
      }

      // Delete feature graphic
      if (app.featureGraphicUrl.isNotEmpty) {
        await storage.refFromURL(app.featureGraphicUrl).delete();
      }

      // Delete screenshots
      for (final url in app.screenshots) {
        await storage.refFromURL(url).delete();
      }
    } catch (e) {
      print('Error deleting app images: $e');
      // Continue with deletion even if image deletion fails
    }
  }

  void _editApp(AppModel? app) {
    showDialog(
      context: context,
      builder: (context) => AppEditorDialog(
        app: app,
        onSave: () {
          _loadApps();
          Navigator.pop(context);
        },
      ),
    );
  }

  List<AppModel> get _filteredApps {
    if (_searchQuery.isEmpty) {
      return _apps;
    }

    return _apps.where((app) {
      final query = _searchQuery.toLowerCase();
      return app.name.toLowerCase().contains(query) ||
          app.shortDescription.toLowerCase().contains(query) ||
          app.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadApps,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'App Management',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (!isNarrow) _buildAddAppButton(),
                              ],
                            ),
                            if (isNarrow) ...[
                              const SizedBox(height: 16),
                              _buildAddAppButton(),
                            ],
                            const SizedBox(height: 16),
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search Apps',
                                hintText:
                                    'Search by name, description, or category',
                                prefixIcon: const Icon(Icons.search),
                                border: const OutlineInputBorder(),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _searchController.clear();
                                            _searchQuery = '';
                                          });
                                        },
                                      )
                                    : null,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _filteredApps.isEmpty
                          ? _buildEmptyState()
                          : _buildAppsList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAddAppButton() {
    return ElevatedButton.icon(
      onPressed: () => _editApp(null),
      icon: const Icon(Icons.add),
      label: const Text('Add New App'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _searchQuery.isEmpty ? Icons.apps_outlined : Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'No apps found. Click "Add New App" to create one.'
                : 'No apps match your search',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isNotEmpty)
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear Search'),
            ),
        ],
      ),
    );
  }

  Widget _buildAppsList() {
    return MediaQuery.of(context).size.width < 900
        ? ListView.builder(
            itemCount: _filteredApps.length,
            itemBuilder: (context, index) =>
                _buildAppCard(_filteredApps[index]),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _filteredApps.length,
            itemBuilder: (context, index) =>
                _buildAppCard(_filteredApps[index]),
          );
  }

  Widget _buildAppCard(AppModel app) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _editApp(app),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Icon
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: app.iconUrl.isNotEmpty
                    ? Image.network(
                        app.iconUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child:
                              const Icon(Icons.image_not_supported, size: 40),
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.apps, size: 40),
                      ),
              ),
              const SizedBox(width: 16),
              // App Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      app.shortDescription,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Chip(
                          label: Text(app.category),
                          labelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text('${app.platforms.length} Platforms'),
                          backgroundColor: Colors.teal.withOpacity(0.1),
                          labelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit App',
                    onPressed: () => _editApp(app),
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete App',
                    onPressed: () => _deleteApp(app),
                    color: Colors.red[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
