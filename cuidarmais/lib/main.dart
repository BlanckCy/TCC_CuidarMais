import 'package:cuidarmais/pages/principal/principal.dart';
import 'package:flutter/material.dart';
import 'package:cuidarmais/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // '/': (context) => const PrincipalPage(),
        // '/medicacao': (context) => MedicacaoPage(),
      },
      title: 'Cuidar+',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 133, 187, 203),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
