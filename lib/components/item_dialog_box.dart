// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';

class ItemDialogBox extends StatefulWidget {
  final String itemName;
  final String itemSpecs;
  const ItemDialogBox(
      {super.key, required this.itemSpecs, required this.itemName});

  @override
  State<ItemDialogBox> createState() => _ItemDialogBoxState();
}

class _ItemDialogBoxState extends State<ItemDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      content: Container(
        width: 800, 
        height: 400, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.itemName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 54, 53, 53),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.edit),
                  color: Color.fromARGB(255, 65, 128, 59),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.delete),
                  color: Color.fromARGB(255, 115, 50, 50),
                ),
              ],
            ),
            Divider(color: Colors.black),
            Text(
              "Specifications: ${widget.itemSpecs}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
