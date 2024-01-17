import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AppDescriptionPage extends StatelessWidget {
  final String title;

  AppDescriptionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
          // middle: Text(
          //   'App Description - $title',
          //   style:  const TextStyle(fontSize: 30, color: Colors.black),
          // ),
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  Future<void> sendEmail(String description, String userEmail, String title,
      String name, String clientWhatsApp) async {
    // Replace these with your actual email configuration
    final smtpServer = gmail('cupertinostudios@gmail.com', 'illustration-2020');

    // Create our email message
    final message = Message()
      ..from = Address('cupertinostudios@gmail.com', name)
      ..recipients
          .add('cupertinostudios@gmail.com') // Replace with your actual email
      ..subject = title
      ..text =
          'User Email: $userEmail\nClient WhatsApp: $clientWhatsApp\n\n$description';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.messageSendingEnd}');
      _showResultDialog('Message sent successfully, we would get back to you soon.');
    } catch (e) {
      print('Error sending email: $e');
       _showResultDialog('Failed to send message, please try again. Error: $e');
    }
  }

  void _showResultDialog(String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Message Result'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

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
        const SizedBox(height: 10),
        TextField(
          controller: clientNameController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: 'Your Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Your Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: whatsappController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: 'Your WhatsApp Number',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add logic to send the message to your desired endpoint
            // For simplicity, we'll just print the description for now
            sendEmail(
              descriptionController.text,
              emailController.text,
              widget.title,
              clientNameController.text,
              whatsappController.text,
            );
            print(
                'App Description for ${widget.title}: ${descriptionController.text}');
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
