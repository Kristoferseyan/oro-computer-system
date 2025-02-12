// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30),
        child: Row(
          children: [
            Container(
              height: 300,
              width: 300,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}