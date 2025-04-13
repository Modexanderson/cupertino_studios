// lib/screens/admin/content_editor.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_html/html.dart' as html;
import '../../services/firebase_service.dart';
import '../../models/website_content_model.dart';

class ContentEditorScreen extends StatefulWidget {
  const ContentEditorScreen({super.key});

  @override
  State<ContentEditorScreen> createState() => _ContentEditorScreenState();
}

class _ContentEditorScreenState extends State<ContentEditorScreen> {
  bool _isLoading = true;
  bool _isSaving = false;
  WebsiteContentModel? _websiteContent;

  final _formKey = GlobalKey<FormState>();
  final _welcomeTitleController = TextEditingController();
  final _welcomeMessageController = TextEditingController();
  final _heroQuoteController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _footerTextController = TextEditingController();

  String _heroImageUrl = '';
  List<PricingPackage> _pricingPackages = [];
  List<FAQ> _faqs = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final firebaseService =
          Provider.of<FirebaseService>(context, listen: false);
      final websiteContent = await firebaseService.getWebsiteContent();

      _welcomeTitleController.text = websiteContent.welcomeTitle;
      _welcomeMessageController.text = websiteContent.welcomeMessage;
      _heroQuoteController.text = websiteContent.heroQuote;
      _contactEmailController.text = websiteContent.contactEmail;
      _footerTextController.text = websiteContent.footerText;

      setState(() {
        _websiteContent = websiteContent;
        _heroImageUrl = websiteContent.heroImageUrl;
        _pricingPackages = List.from(websiteContent.pricingPackages);
        _faqs = List.from(websiteContent.faqs);
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading website content: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickHeroImage() async {
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    final ImagePicker picker = ImagePicker();

    try {
      if (kIsWeb) {
        // For web
        final html.FileUploadInputElement input = html.FileUploadInputElement()
          ..accept = 'image/*';
        input.click();

        await input.onChange.first;

        if (input.files != null && input.files!.isNotEmpty) {
          setState(() {
            _isSaving = true;
          });

          final html.File file = input.files![0];
          final String fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
          final String path = 'website/hero/$fileName';

          final String url = await firebaseService.uploadFile(file, path);

          setState(() {
            _heroImageUrl = url;
            _isSaving = false;
          });
        }
      } else {
        // For mobile
        final XFile? pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
        );

        if (pickedFile != null) {
          setState(() {
            _isSaving = true;
          });

          final String fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
          final String path = 'website/hero/$fileName';

          final String url = await firebaseService.uploadFile(
            File(pickedFile.path),
            path,
          );

          setState(() {
            _heroImageUrl = url;
            _isSaving = false;
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload image')),
      );

      setState(() {
        _isSaving = false;
      });
    }
  }

  void _editPricingPackage(PricingPackage? package, int? index) {
    showDialog(
      context: context,
      builder: (context) => PricingPackageEditor(
        package: package,
        onSave: (updatedPackage) {
          setState(() {
            if (index != null) {
              _pricingPackages[index] = updatedPackage;
            } else {
              _pricingPackages.add(updatedPackage);
            }
          });
        },
      ),
    );
  }

  void _editFAQ(FAQ? faq, int? index) {
    showDialog(
      context: context,
      builder: (context) => FAQEditor(
        faq: faq,
        onSave: (updatedFAQ) {
          setState(() {
            if (index != null) {
              _faqs[index] = updatedFAQ;
            } else {
              _faqs.add(updatedFAQ);
            }
          });
        },
      ),
    );
  }

  Future<void> _saveContent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      try {
        final firebaseService =
            Provider.of<FirebaseService>(context, listen: false);

        final updatedContent = WebsiteContentModel(
          welcomeTitle: _welcomeTitleController.text,
          welcomeMessage: _welcomeMessageController.text,
          heroImageUrl: _heroImageUrl,
          heroQuote: _heroQuoteController.text,
          contactEmail: _contactEmailController.text,
          pricingPackages: _pricingPackages,
          faqs: _faqs,
          footerText: _footerTextController.text,
          updatedAt: Timestamp.now(),
        );

        await firebaseService.updateWebsiteContent(updatedContent);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Website content updated successfully')),
        );

        setState(() {
          _websiteContent = updatedContent;
          _isSaving = false;
        });
      } catch (e) {
        print('Error saving website content: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update website content')),
        );

        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Website Content Editor',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _isSaving ? null : _saveContent,
                          child: _isSaving
                              ? const CircularProgressIndicator()
                              : const Text('Save Changes'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Basic content
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Basic Content',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _welcomeTitleController,
                              decoration: const InputDecoration(
                                labelText: 'Welcome Title',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter welcome title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _welcomeMessageController,
                              decoration: const InputDecoration(
                                labelText: 'Welcome Message',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter welcome message';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _contactEmailController,
                              decoration: const InputDecoration(
                                labelText: 'Contact Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter contact email';
                                }
                                if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _footerTextController,
                              decoration: const InputDecoration(
                                labelText: 'Footer Text',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter footer text';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Hero section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hero Section',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Hero image
                            const Text('Hero Image'),
                            const SizedBox(height: 8),

                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _heroImageUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        _heroImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No image selected'),
                                    ),
                            ),

                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _pickHeroImage,
                              child: const Text('Change Hero Image'),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _heroQuoteController,
                              decoration: const InputDecoration(
                                labelText: 'Hero Quote',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter hero quote';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Pricing Packages
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Pricing Packages',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () =>
                                      _editPricingPackage(null, null),
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add Package'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _pricingPackages.length,
                              itemBuilder: (context, index) {
                                final package = _pricingPackages[index];

                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    title: Text(
                                      package.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${package.description}\nPrice: ${package.price}',
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () => _editPricingPackage(
                                              package, index),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              _pricingPackages.removeAt(index);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // FAQs
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Frequently Asked Questions',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () => _editFAQ(null, null),
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add FAQ'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _faqs.length,
                              itemBuilder: (context, index) {
                                final faq = _faqs[index];

                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ExpansionTile(
                                    title: Text(
                                      faq.question,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(faq.answer),
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () =>
                                                      _editFAQ(faq, index),
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    setState(() {
                                                      _faqs.removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class PricingPackageEditor extends StatefulWidget {
  final PricingPackage? package;
  final Function(PricingPackage) onSave;

  const PricingPackageEditor({
    super.key,
    this.package,
    required this.onSave,
  });

  @override
  State<PricingPackageEditor> createState() => _PricingPackageEditorState();
}

class _PricingPackageEditorState extends State<PricingPackageEditor> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _featureController = TextEditingController();

  List<String> _features = [];

  @override
  void initState() {
    super.initState();

    if (widget.package != null) {
      _titleController.text = widget.package!.title;
      _descriptionController.text = widget.package!.description;
      _priceController.text = widget.package!.price;
      _features = List.from(widget.package!.features);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.package == null
                ? 'Add Pricing Package'
                : 'Edit Pricing Package'),
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedPackage = PricingPackage(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      price: _priceController.text,
                      features: _features,
                    );

                    widget.onSave(updatedPackage);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter package title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter package description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter package price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Features',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _featureController,
                          decoration: const InputDecoration(
                            labelText: 'Add Feature',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_featureController.text.isNotEmpty) {
                            setState(() {
                              _features.add(_featureController.text);
                              _featureController.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_features.isEmpty)
                    const Center(
                      child: Text(
                        'No features added yet',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _features.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.check),
                          title: Text(_features[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _features.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FAQEditor extends StatefulWidget {
  final FAQ? faq;
  final Function(FAQ) onSave;

  const FAQEditor({
    super.key,
    this.faq,
    required this.onSave,
  });

  @override
  State<FAQEditor> createState() => _FAQEditorState();
}

class _FAQEditorState extends State<FAQEditor> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.faq != null) {
      _questionController.text = widget.faq!.question;
      _answerController.text = widget.faq!.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.faq == null ? 'Add FAQ' : 'Edit FAQ'),
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedFAQ = FAQ(
                      question: _questionController.text,
                      answer: _answerController.text,
                    );

                    widget.onSave(updatedFAQ);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      labelText: 'Question',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a question';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _answerController,
                    decoration: const InputDecoration(
                      labelText: 'Answer',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an answer';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
