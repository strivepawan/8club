import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  final String title;
  const ComingSoonPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, color: Colors.white, size: 60),
            SizedBox(height: 16),
            Text(
              'Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}