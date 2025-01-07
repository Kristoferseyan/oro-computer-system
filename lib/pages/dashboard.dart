// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:orocomputer_system/pages/home_page.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:orocomputer_system/utils/custom_gnav.dart';
import '';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    int _selectedIndex = 0;

    static const List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      Text('Add Items'),
      Text('Settings')
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomGnav(onTabChange: (index){
        setState(() {
          _selectedIndex = index;
        });
      }, selectedIndex: _selectedIndex),
    );
  }
}
