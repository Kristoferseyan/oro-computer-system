// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orocomputer_system/utils/colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/Oro.png') 
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                   
                ), 
                child: Text(
                  "Dashboard",
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),)
          ],
        ), 
      ), 
    );
  }
}