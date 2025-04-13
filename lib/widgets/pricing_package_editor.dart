import 'package:flutter/material.dart';
import '../../models/website_content_model.dart';
import '../../theme/app_theme.dart';

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
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _featureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
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
              title: Text(widget.package == null
                  ? 'Add Pricing Package'
                  : 'Edit Pricing Package'),
              automaticallyImplyLeading: false,
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
                  icon: const Icon(Icons.save),
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Package info section
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Package Title',
                        hintText: 'e.g. Basic, Pro, Enterprise',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
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
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: 'e.g. \$99/month, Free, Contact Us',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter package price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Brief description of this package',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter package description';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Features section
                    const Text(
                      'Package Features',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Add feature field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _featureController,
                            decoration: const InputDecoration(
                              labelText: 'Feature',
                              hintText: 'Enter a feature for this package',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.check_circle_outline),
                            ),
                            onFieldSubmitted: (_) {
                              _addFeature();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _addFeature,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('Add'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Features list
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
                                  Icons.featured_play_list,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Features List',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${_features.length} Features',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            if (_features.isEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    'No features added yet',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _features.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                        radius: 16,
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
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
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addFeature() {
    if (_featureController.text.isNotEmpty) {
      setState(() {
        _features.add(_featureController.text);
        _featureController.clear();
      });
    }
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
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
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
              title: Text(widget.faq == null ? 'Add FAQ' : 'Edit FAQ'),
              automaticallyImplyLeading: false,
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
                  icon: const Icon(Icons.save),
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    TextFormField(
                      controller: _questionController,
                      decoration: const InputDecoration(
                        labelText: 'Question',
                        hintText: 'Enter the frequently asked question',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.help_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a question';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Answer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Answer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _answerController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a detailed answer to the question',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 12,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an answer';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Preview
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
                                  Icons.visibility,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Preview',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            ExpansionTile(
                              title: Text(
                                _questionController.text.isEmpty
                                    ? 'Question Preview'
                                    : _questionController.text,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              childrenPadding: const EdgeInsets.all(16),
                              children: [
                                Text(
                                  _answerController.text.isEmpty
                                      ? 'Answer preview will appear here'
                                      : _answerController.text,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
