// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';

class ListItemsDialogBox extends StatefulWidget {
  final String itemName;
  final String itemStock;


  const ListItemsDialogBox(
    {super.key, required this.itemName, required this.itemStock });

  @override
  State<ListItemsDialogBox> createState() => _ListItemsDialogBoxState();
}

class _ListItemsDialogBoxState extends State<ListItemsDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      content: SizedBox(
        width: 300,
        height: 300,
      ),
    );
  }
}