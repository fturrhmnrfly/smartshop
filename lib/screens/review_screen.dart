// lib/screens/review_screen.dart
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'User Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star, color: Colors.amber, size: 20),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Great product! Really satisfied with the quality.'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
