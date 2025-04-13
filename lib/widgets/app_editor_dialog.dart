import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_html/html.dart' as html;
import '../../services/firebase_service.dart';
import '../../models/app_model.dart';
import '../../theme/app_theme.dart';

class AppEditorDialog extends StatefulWidget {
  final AppModel? app;
  final VoidCallback onSave;

  const AppEditorDialog({
    super.key,
    this.app,
    required this.onSave,
  });

  @override
  State<AppEditorDialog> createState() => _AppEditorDialogState();
}

class _AppEditorDialogState extends State<AppEditorDialog>
    with SingleTickerProviderStateMixin {
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shortDescController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _whatsNewController = TextEditingController();
  final _dataSafetyController = TextEditingController();
  final _downloadsController = TextEditingController();
  final _ratingController = TextEditingController();
  late TabController _tabController;

  // App data
  bool _containsAds = false;
  bool _hasInAppPurchases = false;
  String _iconUrl = '';
  String _featureGraphicUrl = '';
  List<String> _screenshots = [];
  List<String> _platforms = [];
  Map<String, String> _downloadUrls = {};
  Map<String, String> _storeUrls = {};
  List<String> _features = [];

  // File tracking for delayed upload
  dynamic _iconFile;
  dynamic _featureGraphicFile;
  List<dynamic> _screenshotFiles = [];
  bool _iconChanged = false;
  bool _featureGraphicChanged = false;
  List<bool> _screenshotsAdded = [];

  bool _isLoading = false;
  final List<String> _availablePlatforms = [
    'Android',
    'iOS',
    'Windows',
    'macOS',
    'Linux',
    'Web',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadAppData();
  }

  void _loadAppData() {
    if (widget.app != null) {
      _nameController.text = widget.app!.name;
      _shortDescController.text = widget.app!.shortDescription;
      _descriptionController.text = widget.app!.description;
      _categoryController.text = widget.app!.category;
      _whatsNewController.text = widget.app!.whatsNew;
      _dataSafetyController.text = widget.app!.dataSafety;
      _downloadsController.text = widget.app!.downloadsCount.toString();
      _ratingController.text = widget.app!.rating;

      _containsAds = widget.app!.containsAds;
      _hasInAppPurchases = widget.app!.hasInAppPurchases;
      _iconUrl = widget.app!.iconUrl;
      _featureGraphicUrl = widget.app!.featureGraphicUrl;
      _screenshots = List.from(widget.app!.screenshots);
      _platforms = List.from(widget.app!.platforms);
      _downloadUrls = Map.from(widget.app!.downloadUrls);
      _storeUrls = Map.from(widget.app!.storeUrls);
      _features = List.from(widget.app!.features);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortDescController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _whatsNewController.dispose();
    _dataSafetyController.dispose();
    _downloadsController.dispose();
    _ratingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Image selection handling
  Future<void> _pickImage(String type) async {
    final ImagePicker picker = ImagePicker();

    try {
      if (kIsWeb) {
        await _pickWebImage(type);
      } else {
        await _pickMobileImage(type, picker);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to select image: ${e.toString()}');
    }
  }

  Future<void> _pickWebImage(String type) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*';
    input.click();

    await input.onChange.first;
    if (input.files == null || input.files!.isEmpty) return;

    final html.File file = input.files![0];
    final reader = html.FileReader();
    reader.readAsDataUrl(file);

    await reader.onLoad.first;
    final previewUrl = reader.result as String;

    setState(() {
      if (type == 'icon') {
        _iconFile = file;
        _iconChanged = true;
        _iconUrl = previewUrl;
      } else if (type == 'feature') {
        _featureGraphicFile = file;
        _featureGraphicChanged = true;
        _featureGraphicUrl = previewUrl;
      } else if (type == 'screenshots') {
        _screenshotFiles.add(file);
        _screenshotsAdded.add(true);
        _screenshots.add(previewUrl);
      }
    });
  }

  Future<void> _pickMobileImage(String type, ImagePicker picker) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final File file = File(pickedFile.path);
    setState(() {
      if (type == 'icon') {
        _iconFile = file;
        _iconChanged = true;
        _iconUrl = pickedFile.path;
      } else if (type == 'feature') {
        _featureGraphicFile = file;
        _featureGraphicChanged = true;
        _featureGraphicUrl = pickedFile.path;
      } else if (type == 'screenshots') {
        _screenshotFiles.add(file);
        _screenshotsAdded.add(true);
        _screenshots.add(pickedFile.path);
      }
    });
  }

  void _removeScreenshot(int index) {
    setState(() {
      if (index < _screenshotsAdded.length && _screenshotsAdded[index]) {
        final addedIndex = _screenshotsAdded.indexOf(true);
        if (addedIndex != -1) {
          _screenshotFiles
              .removeAt(_screenshotsAdded.indexWhere((added) => added == true));
          _screenshotsAdded.removeAt(index);
        }
      }
      _screenshots.removeAt(index);
    });
  }

  void _addFeature() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Feature'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Feature',
            hintText: 'Enter a feature of your app',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _features.add(controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addPlatformUrl(String type) {
    String platform = _availablePlatforms.first;
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${type == 'download' ? 'Download' : 'Store'} URL'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: platform,
              decoration: const InputDecoration(
                labelText: 'Platform',
                border: OutlineInputBorder(),
              ),
              items: _availablePlatforms
                  .map((platform) => DropdownMenuItem<String>(
                        value: platform,
                        child: Text(platform),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) platform = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: type == 'download' ? 'Download URL' : 'Store URL',
                hintText: 'Enter the URL',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isNotEmpty) {
                setState(() {
                  if (type == 'download') {
                    _downloadUrls[platform] = urlController.text;
                  } else {
                    _storeUrls[platform] = urlController.text;
                  }
                  if (!_platforms.contains(platform)) {
                    _platforms.add(platform);
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // File upload
  Future<void> _saveApp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final firebaseService =
          Provider.of<FirebaseService>(context, listen: false);

      // Upload all files to Firebase before saving the app data
      await _uploadAllPendingFiles();

      // Create app data model
      final AppModel appData = AppModel(
        id: widget.app?.id ?? '',
        name: _nameController.text,
        shortDescription: _shortDescController.text,
        description: _descriptionController.text,
        iconUrl: _iconUrl,
        featureGraphicUrl: _featureGraphicUrl,
        screenshots: _screenshots,
        platforms: _platforms,
        containsAds: _containsAds,
        hasInAppPurchases: _hasInAppPurchases,
        category: _categoryController.text,
        downloadUrls: _downloadUrls,
        storeUrls: _storeUrls,
        features: _features,
        whatsNew: _whatsNewController.text,
        dataSafety: _dataSafetyController.text,
        downloadsCount: int.tryParse(_downloadsController.text) ?? 0,
        rating: _ratingController.text,
        createdAt: widget.app?.createdAt ?? Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      // Save app data
      if (widget.app == null) {
        await firebaseService.addApp(appData);
        _showSuccessSnackBar('App created successfully');
      } else {
        await firebaseService.updateApp(appData);
        _showSuccessSnackBar('App updated successfully');
      }

      widget.onSave();
    } catch (e) {
      _showErrorSnackBar('Failed to save app: ${e.toString()}');
      setState(() => _isLoading = false);
    }
  }

  Future<String> _uploadFileToFirebase(dynamic file, String path) async {
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    return await firebaseService.uploadFile(file, path);
  }

  Future<void> _uploadAllPendingFiles() async {
    final appName = _nameController.text;

    // Upload icon if changed
    if (_iconChanged && _iconFile != null) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_icon';
      final String path = 'apps/$appName/icon/$fileName';
      _iconUrl = await _uploadFileToFirebase(_iconFile, path);
    }

    // Upload feature graphic if changed
    if (_featureGraphicChanged && _featureGraphicFile != null) {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_feature';
      final String path = 'apps/$appName/feature/$fileName';
      _featureGraphicUrl =
          await _uploadFileToFirebase(_featureGraphicFile, path);
    }

    // Process screenshots - keep existing ones and upload new ones
    List<String> finalScreenshotUrls = [];

    // Add existing screenshots
    for (int i = 0; i < _screenshots.length; i++) {
      if (i >= _screenshotsAdded.length || !_screenshotsAdded[i]) {
        finalScreenshotUrls.add(_screenshots[i]);
      }
    }

    // Upload new screenshots
    for (int i = 0; i < _screenshotFiles.length; i++) {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_screenshot_$i';
      final String path = 'apps/$appName/screenshots/$fileName';
      String url = await _uploadFileToFirebase(_screenshotFiles[i], path);
      finalScreenshotUrls.add(url);
    }

    // Update screenshots with final URLs
    _screenshots = finalScreenshotUrls;
  }

  // UI helpers
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 800),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.app == null
                  ? 'Add New App'
                  : 'Edit ${widget.app!.name}'),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Basic Info'),
                  Tab(text: 'Images'),
                  Tab(text: 'Features'),
                  Tab(text: 'Download URLs'),
                  Tab(text: 'Store URLs'),
                  Tab(text: 'Additional Info'),
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: _isLoading ? null : _saveApp,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: const Text('Save'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            body: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicInfoTab(),
                  _buildImagesTab(),
                  _buildFeaturesTab(),
                  _buildDownloadUrlsTab(),
                  _buildStoreUrlsTab(),
                  _buildAdditionalInfoTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Tab content builders
  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // App name field
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'App Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter app name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Short description field
          TextFormField(
            controller: _shortDescController,
            decoration: const InputDecoration(
              labelText: 'Short Description',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.short_text),
              helperText: 'Brief app description (appears in app lists)',
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter short description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Full description field
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Full Description',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
              helperText: 'Detailed description of your app',
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Categorization and metrics
          Card(
            elevation: 0,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categorization & Metrics',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _downloadsController,
                          decoration: const InputDecoration(
                            labelText: 'Downloads Count',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.download),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _ratingController,
                          decoration: const InputDecoration(
                            labelText: 'Rating',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.star),
                            hintText: '4.5',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Properties
          Card(
            elevation: 0,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Additional Properties',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text('Contains Ads'),
                          subtitle: const Text('App includes advertisements'),
                          value: _containsAds,
                          onChanged: (value) =>
                              setState(() => _containsAds = value ?? false),
                          secondary: const Icon(Icons.ads_click),
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text('In-App Purchases'),
                          subtitle: const Text('App has in-app purchases'),
                          value: _hasInAppPurchases,
                          onChanged: (value) => setState(
                              () => _hasInAppPurchases = value ?? false),
                          secondary: const Icon(Icons.shopping_cart),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'App Images',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload images to showcase your app. All images will be uploaded when you save the form.',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Icon and Feature Graphic Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'App Icon',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Recommended size: 512x512',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: _buildImageSelector(
                            imageUrl: _iconUrl,
                            isChanged: _iconChanged,
                            width: 150,
                            height: 150,
                            onSelect: () => _pickImage('icon'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Feature Graphic',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Recommended size: 1024x500',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: _buildImageSelector(
                            imageUrl: _featureGraphicUrl,
                            isChanged: _featureGraphicChanged,
                            width: double.infinity,
                            height: 150,
                            onSelect: () => _pickImage('feature'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Screenshots Section
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Screenshots',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Recommended size: 1242x2688 (portrait) or 2688x1242 (landscape)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage('screenshots'),
                        icon: const Icon(Icons.add_photo_alternate),
                        label: const Text('Add Screenshot'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Screenshots Grid
                  _screenshots.isEmpty
                      ? Container(
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            'No screenshots added',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: _screenshots.length,
                          itemBuilder: (context, index) {
                            final bool isNewScreenshot =
                                index < _screenshotsAdded.length &&
                                    _screenshotsAdded[index];

                            return _buildScreenshotItem(
                              index: index,
                              imageUrl: _screenshots[index],
                              isChanged: isNewScreenshot,
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSelector({
    required String imageUrl,
    required bool isChanged,
    required double width,
    required double height,
    required VoidCallback onSelect,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isChanged ? Theme.of(context).primaryColor : Colors.grey[300]!,
          width: isChanged ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          if (imageUrl.isNotEmpty)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: kIsWeb || isChanged
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imageUrl),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onSelect,
                child: imageUrl.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Select Image',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
          if (isChanged)
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Pending Upload',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScreenshotItem({
    required int index,
    required String imageUrl,
    required bool isChanged,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChanged
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300]!,
              width: isChanged ? 2 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: kIsWeb || isChanged
                ? Image.network(
                    imageUrl,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(imageUrl),
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () => _removeScreenshot(index),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
        if (isChanged)
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Pending',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeaturesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'App Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Highlight key features of your app',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _addFeature,
                icon: const Icon(Icons.add),
                label: const Text('Add Feature'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Features are displayed on your app details page',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_features.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.featured_play_list_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No features added yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: _addFeature,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Feature'),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _features.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(_features[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red[400],
                      onPressed: () {
                        setState(() {
                          _features.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildStoreUrlsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Store URLs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Links to app store pages',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _addPlatformUrl('store'),
                icon: const Icon(Icons.add_link),
                label: const Text('Add Store URL'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_storeUrls.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.storefront_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No store URLs added yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => _addPlatformUrl('store'),
                    icon: const Icon(Icons.add_link),
                    label: const Text('Add Store URL'),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _storeUrls.length,
              itemBuilder: (context, index) {
                final platform = _storeUrls.keys.elementAt(index);
                final url = _storeUrls.values.elementAt(index);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildPlatformIcon(platform),
                            const SizedBox(width: 12),
                            Text(
                              platform,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red[400],
                              onPressed: () {
                                setState(() {
                                  _storeUrls.remove(platform);
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.link,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  url,
                                  style: TextStyle(
                                    color: Colors.blue[700],
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
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // What's New Section
          TextFormField(
            controller: _whatsNewController,
            decoration: const InputDecoration(
              labelText: 'What\'s New',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.new_releases),
              helperText: 'Recent updates or changes in the app',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 24),

          // Data Safety Section
          TextFormField(
            controller: _dataSafetyController,
            decoration: const InputDecoration(
              labelText: 'Data Safety',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.privacy_tip),
              helperText: 'Information about how user data is handled',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 24),

          // Platform Selection
          Card(
            elevation: 0,
            color: Theme.of(context).highlightColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Supported Platforms',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availablePlatforms.map((platform) {
                      final bool isSelected = _platforms.contains(platform);
                      return ChoiceChip(
                        label: Text(platform),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              if (!_platforms.contains(platform)) {
                                _platforms.add(platform);
                              }
                            } else {
                              _platforms.remove(platform);
                            }
                          });
                        },
                        selectedColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Icon(
          Icons.android,
          color: Colors.green[700],
          size: 32,
        );
      case 'ios':
        return Icon(
          Icons.apple,
          color: Colors.grey[800],
          size: 32,
        );
      case 'windows':
        return Icon(
          Icons.desktop_windows,
          color: Colors.blue[700],
          size: 32,
        );
      case 'macos':
        return Icon(
          Icons.desktop_mac,
          color: Colors.grey[800],
          size: 32,
        );
      case 'linux':
        return Icon(
          Icons.computer,
          color: Colors.orange[700],
          size: 32,
        );
      case 'web':
        return Icon(
          Icons.web,
          color: Colors.purple[700],
          size: 32,
        );
      default:
        return Icon(
          Icons.devices_other,
          color: Colors.grey[600],
          size: 32,
        );
    }
  }

  Widget _buildDownloadUrlsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Download URLs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Direct download links for your app',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _addPlatformUrl('download'),
                icon: const Icon(Icons.add_link),
                label: const Text('Add Download URL'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_downloadUrls.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No download URLs added yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => _addPlatformUrl('download'),
                    icon: const Icon(Icons.add_link),
                    label: const Text('Add Download URL'),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _downloadUrls.length,
              itemBuilder: (context, index) {
                final platform = _downloadUrls.keys.elementAt(index);
                final url = _downloadUrls.values.elementAt(index);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildPlatformIcon(platform),
                            const SizedBox(width: 12),
                            Text(
                              platform,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red[400],
                              onPressed: () {
                                setState(() {
                                  _downloadUrls.remove(platform);
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.link,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  url,
                                  style: TextStyle(
                                    color: Colors.blue[700],
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
              },
            ),
        ],
      ),
    );
  }
}
