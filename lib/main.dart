import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CivicConnectApp());
}

class CivicConnectApp extends StatelessWidget {
  const CivicConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Civic Connect',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // The app starts here
      home: const LoginScreen(),
    );
  }
}