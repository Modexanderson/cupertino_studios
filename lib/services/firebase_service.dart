// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import '../models/app_model.dart';
import '../models/user_model.dart';
import '../models/website_content_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection references
  CollectionReference get appsCollection => _firestore.collection('apps');
  CollectionReference get usersCollection => _firestore.collection('users');
  DocumentReference get websiteContentDoc =>
      _firestore.collection('content').doc('website');

  // Apps CRUD operations
  Future<List<AppModel>> getApps() async {
    try {
      QuerySnapshot snapshot = await appsCollection.orderBy('name').get();
      return snapshot.docs.map((doc) => AppModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching apps: $e');
      return [];
    }
  }

  Future<AppModel?> getAppById(String appId) async {
    try {
      DocumentSnapshot doc = await appsCollection.doc(appId).get();
      if (doc.exists) {
        return AppModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching app by ID: $e');
      return null;
    }
  }

  Future<String> addApp(AppModel app) async {
    try {
      DocumentReference docRef = await appsCollection.add(app.toFirestore());
      return docRef.id;
    } catch (e) {
      print('Error adding app: $e');
      throw e;
    }
  }

  Future<void> updateApp(AppModel app) async {
    try {
      await appsCollection.doc(app.id).update(app.toFirestore());
    } catch (e) {
      print('Error updating app: $e');
      throw e;
    }
  }

  Future<void> deleteApp(String appId) async {
    try {
      await appsCollection.doc(appId).delete();
    } catch (e) {
      print('Error deleting app: $e');
      throw e;
    }
  }

  // Website content operations
  Future<WebsiteContentModel> getWebsiteContent() async {
    try {
      DocumentSnapshot doc = await websiteContentDoc.get();
      if (doc.exists) {
        return WebsiteContentModel.fromFirestore(doc);
      } else {
        // Create default content if none exists
        WebsiteContentModel defaultContent = WebsiteContentModel(
          welcomeTitle: 'Welcome to Cupertino Studios',
          welcomeMessage: 'We build beautiful and powerful mobile apps.',
          heroImageUrl:
              'https://firebasestorage.googleapis.com/v0/b/cupertino-studios-website.appspot.com/o/home-screen-image.jpg?alt=media&token=bdf46aa0-6c06-4ac9-8cb3-ce5f67dc0413',
          heroQuote:
              '"High-quality mobile apps are more than just lines of code. They are seamless experiences, crafted with precision and care, that delight users and solve their everyday challenges."',
          contactEmail: 'cupertinostudios@gmail.com',
          pricingPackages: [
            PricingPackage(
              title: 'Basic Package',
              description: 'Perfect for small businesses and startups',
              price: '\$299 - \$799',
              features: [
                'Up to 5 pages',
                'Basic UI/UX design',
                '1-2 app integrations',
                'Limited support'
              ],
            ),
            PricingPackage(
              title: 'Pro Package',
              description: 'Great for growing businesses',
              price: '\$799 - \$1,499',
              features: [
                'Up to 10 pages',
                'Custom UI/UX design',
                '3-5 app integrations',
                'Priority support'
              ],
            ),
            PricingPackage(
              title: 'Enterprise Package',
              description: 'Tailored solutions for large enterprises',
              price: '\$1,500+',
              features: [
                'Custom number of pages',
                'Highly polished UI/UX design',
                'Advanced app integrations',
                '24/7 premium support'
              ],
            ),
          ],
          faqs: [
            FAQ(
              question: 'What does "3-5 app integrations" mean?',
              answer:
                  'In the context of our pricing packages, "3-5 app integrations" refers to the number of external services or functionalities that we can integrate into your mobile app. Examples include social media logins, payment gateways, maps, push notifications, or any other third-party APIs to enhance your app\'s capabilities.',
            ),
            FAQ(
              question: 'How long does it take to develop a mobile app?',
              answer:
                  'The timeline for mobile app development varies based on the complexity of the project, features required, and client feedback. A basic app may take a few weeks, while more complex apps can take several months. We work closely with clients to provide realistic timelines and milestones.',
            ),
            FAQ(
              question: 'Do you offer post-launch support?',
              answer:
                  'Yes, we offer post-launch support to address any issues, bugs, or additional features you may need. The level of support depends on the chosen pricing package. Our goal is to ensure your app functions smoothly and evolves according to your business needs.',
            ),
          ],
          footerText: '© 2023 Cupertino Studios. All rights reserved.',
          updatedAt: Timestamp.now(),
        );
        await websiteContentDoc.set(defaultContent.toFirestore());
        return defaultContent;
      }
    } catch (e) {
      print('Error fetching website content: $e');
      throw e;
    }
  }

  Future<void> updateWebsiteContent(WebsiteContentModel content) async {
    try {
      await websiteContentDoc.update(content.toFirestore());
    } catch (e) {
      print('Error updating website content: $e');
      throw e;
    }
  }

  // Storage operations
  Future<String> uploadFile(dynamic file, String path) async {
    try {
      Reference storageRef = _storage.ref().child(path);

      UploadTask uploadTask;
      if (kIsWeb) {
        // For web
        if (file is html.File) {
          Uint8List bytes = await _readFileAsBytes(file);
          uploadTask = storageRef.putData(bytes);
        } else {
          throw Exception('Invalid file type for web upload');
        }
      } else {
        // For mobile
        if (file is File) {
          uploadTask = storageRef.putFile(file);
        } else if (file is Uint8List) {
          uploadTask = storageRef.putData(file);
        } else {
          throw Exception('Invalid file type for mobile upload');
        }
      }

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }

  Future<Uint8List> _readFileAsBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    return reader.result as Uint8List;
  }

  Future<void> deleteFile(String url) async {
    try {
      Reference ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Error deleting file: $e');
      throw e;
    }
  }
}
