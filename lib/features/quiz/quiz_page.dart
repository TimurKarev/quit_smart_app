import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement localization for QuizPage title
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'), // Placeholder title
      ),
      body: const Center(
        child: Text('Quiz Page Content'), // Placeholder content
      ),
    );
  }
}
