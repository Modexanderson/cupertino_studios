// lib/widgets/footer.dart
import 'package:flutter/material.dart';

class WebsiteFooter extends StatelessWidget {
  final String footerText;

  const WebsiteFooter({
    super.key,
    required this.footerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              footerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                overflow: TextOverflow.clip,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
