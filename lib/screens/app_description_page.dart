import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDescriptionPage extends StatelessWidget {
  final String title;

  AppDescriptionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: Text(
            'App Description - $title',
            style:  const TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Describe Your App - $title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            AppDescriptionForm(title: title),
          ],
        ),
      ),
    );
  }
}

class AppDescriptionForm extends StatefulWidget {
  final String title;

  AppDescriptionForm({super.key, required this.title});

  @override
  _AppDescriptionFormState createState() => _AppDescriptionFormState();
}

class _AppDescriptionFormState extends State<AppDescriptionForm> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: descriptionController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Provide a brief description of your app...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add logic to send the message to your desired endpoint
            // For simplicity, we'll just print the description for now
            print('App Description for ${widget.title}: ${descriptionController.text}');
            // You can add additional logic here to send the description to your backend
            // or handle the data as needed
            // For example, you can use a package like http to send a POST request.
          },
          child: const Text('Send Message'),
        ),
      ],
    );
  }
}