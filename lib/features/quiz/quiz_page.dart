import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  // Function to write to Firestore
  Future<void> _writeTestStringToFirestore() async {
    debugPrint('Attempting to write to Firestore...'); // Log start
    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection('quiz_interactions');
      debugPrint(
        'Got Firestore instance and collection reference.',
      ); // Log instance/collection access

      final data = {
        'message': 'QuizPage loaded',
        'timestamp': FieldValue.serverTimestamp(),
      };
      debugPrint('Data to write: $data'); // Log data

      DocumentReference docRef = await collection.add(data);
      debugPrint(
        'Successfully wrote test string to Firestore with doc ID: ${docRef.id}',
      );
    } on FirebaseException catch (e) {
      debugPrint('Error writing to Firestore: $e');
      // Log success with ID
    } catch (e, s) {
      // Catch stack trace too
      debugPrint('Error writing to Firestore: $e');
      debugPrint('Stack trace: $s'); // Log stack trace
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement localization for QuizPage title
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'), // Placeholder title
      ),
      body: const Center(
        child: Text(
          'Quiz Page Content - Check Debug Console for Firestore write status',
        ), // Updated placeholder content
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _writeTestStringToFirestore();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
