import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Detail')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Details about the place...'),
          // Add more content
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Launch Google Maps
        },
        child: const Text('Get Directions'),
      ),
    );
  }
}
