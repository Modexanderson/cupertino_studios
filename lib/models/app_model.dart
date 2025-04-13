// lib/models/app_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final String iconUrl;
  final String featureGraphicUrl;
  final List<String> screenshots;
  final List<String> platforms;
  final bool containsAds;
  final bool hasInAppPurchases;
  final String category;
  final Map<String, String> downloadUrls;
  final Map<String, String> storeUrls;
  final List<String> features;
  final String whatsNew;
  final String dataSafety;
  final int downloadsCount;
  final String rating;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.iconUrl,
    required this.featureGraphicUrl,
    required this.screenshots,
    required this.platforms,
    required this.containsAds,
    required this.hasInAppPurchases,
    required this.category,
    required this.downloadUrls,
    required this.storeUrls,
    required this.features,
    required this.whatsNew,
    required this.dataSafety,
    required this.downloadsCount,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AppModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      shortDescription: data['shortDescription'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
      featureGraphicUrl: data['featureGraphicUrl'] ?? '',
      screenshots: List<String>.from(data['screenshots'] ?? []),
      platforms: List<String>.from(data['platforms'] ?? []),
      containsAds: data['containsAds'] ?? false,
      hasInAppPurchases: data['hasInAppPurchases'] ?? false,
      category: data['category'] ?? '',
      downloadUrls: Map<String, String>.from(data['downloadUrls'] ?? {}),
      storeUrls: Map<String, String>.from(data['storeUrls'] ?? {}),
      features: List<String>.from(data['features'] ?? []),
      whatsNew: data['whatsNew'] ?? '',
      dataSafety: data['dataSafety'] ?? '',
      downloadsCount: data['downloadsCount'] ?? 0,
      rating: data['rating'] ?? '0',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'shortDescription': shortDescription,
      'iconUrl': iconUrl,
      'featureGraphicUrl': featureGraphicUrl,
      'screenshots': screenshots,
      'platforms': platforms,
      'containsAds': containsAds,
      'hasInAppPurchases': hasInAppPurchases,
      'category': category,
      'downloadUrls': downloadUrls,
      'storeUrls': storeUrls,
      'features': features,
      'whatsNew': whatsNew,
      'dataSafety': dataSafety,
      'downloadsCount': downloadsCount,
      'rating': rating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
