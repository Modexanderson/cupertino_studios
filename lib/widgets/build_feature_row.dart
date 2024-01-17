import 'package:flutter/material.dart';

Widget buildFeatureRow(IconData iconData, String title, String description) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Icon(iconData, size: 25, color: Colors.black),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth > 900 ? 20 : 16,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }