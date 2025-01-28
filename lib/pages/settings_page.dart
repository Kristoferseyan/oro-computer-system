// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void exit (){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed:exit, child: Text("Exit")),
          )
        ],
      ),
    );
  }
}