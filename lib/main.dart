import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter_firebase_appium/providers/auth_provider.dart';
import 'package:loginflutter_firebase_appium/providers/login_provider.dart';
import 'package:loginflutter_firebase_appium/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormLogin(),
    );
  }
}
