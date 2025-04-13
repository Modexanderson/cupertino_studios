// lib/models/website_content_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PricingPackage {
  final String title;
  final String description;
  final String price;
  final List<String> features;

  PricingPackage({
    required this.title,
    required this.description,
    required this.price,
    required this.features,
  });

  factory PricingPackage.fromMap(Map<String, dynamic> data) {
    return PricingPackage(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      features: List<String>.from(data['features'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'features': features,
    };
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });

  factory FAQ.fromMap(Map<String, dynamic> data) {
    return FAQ(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}

class WebsiteContentModel {
  final String welcomeTitle;
  final String welcomeMessage;
  final String heroImageUrl;
  final String heroQuote;
  final String contactEmail;
  final List<PricingPackage> pricingPackages;
  final List<FAQ> faqs;
  final String footerText;
  final Timestamp updatedAt;

  WebsiteContentModel({
    required this.welcomeTitle,
    required this.welcomeMessage,
    required this.heroImageUrl,
    required this.heroQuote,
    required this.contactEmail,
    required this.pricingPackages,
    required this.faqs,
    required this.footerText,
    required this.updatedAt,
  });

  factory WebsiteContentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return WebsiteContentModel(
      welcomeTitle: data['welcomeTitle'] ?? 'Welcome to Cupertino Studios',
      welcomeMessage: data['welcomeMessage'] ??
          'We build beautiful and powerful mobile apps.',
      heroImageUrl: data['heroImageUrl'] ?? '',
      heroQuote: data['heroQuote'] ??
          '"High-quality mobile apps are more than just lines of code. They are seamless experiences, crafted with precision and care, that delight users and solve their everyday challenges."',
      contactEmail: data['contactEmail'] ?? 'cupertinostudios@gmail.com',
      pricingPackages: (data['pricingPackages'] as List?)
              ?.map((package) => PricingPackage.fromMap(package))
              .toList() ??
          [],
      faqs: (data['faqs'] as List?)?.map((faq) => FAQ.fromMap(faq)).toList() ??
          [],
      footerText: data['footerText'] ??
          '© 2023 Cupertino Studios. All rights reserved.',
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'welcomeTitle': welcomeTitle,
      'welcomeMessage': welcomeMessage,
      'heroImageUrl': heroImageUrl,
      'heroQuote': heroQuote,
      'contactEmail': contactEmail,
      'pricingPackages':
          pricingPackages.map((package) => package.toMap()).toList(),
      'faqs': faqs.map((faq) => faq.toMap()).toList(),
      'footerText': footerText,
      'updatedAt': updatedAt,
    };
  }
}
