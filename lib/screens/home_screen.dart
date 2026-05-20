import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loginflutter_firebase_appium/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthenticationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            key: const ValueKey('key_signout_button'),
            onPressed: () async {
              await authProvider.signOut();
              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil("/formLogin", (_) => false);
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Container(
          key: const ValueKey('container_text_home'),
          alignment: Alignment.center,
          child: Text(
            'Bienvenido a HOME',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
