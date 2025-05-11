import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quit_smart_app/features/auth/ui/bloc/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Home Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dispatch the sign-out event
                context.read<AuthBloc>().add(const AuthSignOutRequested());
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
