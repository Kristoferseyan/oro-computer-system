// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/pages/dashboard.dart';
import 'package:orocomputer_system/pages/landing_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  await dotenv.load(fileName: 'assets/auth.env');
  final String supabaseURL = dotenv.env['SUPABASE_URL']!;
  final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

  await Supabase.initialize(
    anonKey: supabaseAnonKey,
    url: supabaseURL
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/landingpage': (context) => LandingPage(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 14, fontStyle: FontStyle.normal, color: Colors.white),
        )
      ),
    );
  }
}
