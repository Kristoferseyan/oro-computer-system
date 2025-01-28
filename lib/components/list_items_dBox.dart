// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListItemsDialogBox extends StatefulWidget {
  final String itemName;
  final String itemStock;
  final String categoryName;

  const ListItemsDialogBox(
      {super.key, required this.categoryName ,required this.itemName, required this.itemStock});

  @override
  State<ListItemsDialogBox> createState() => _ListItemsDialogBoxState();
}

class _ListItemsDialogBoxState extends State<ListItemsDialogBox> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> items = [];

  void fetchItems() async {
    final response = await supabase.from('products').select('*');
    setState(() {
      items = response;
    });
  }

  void showItems() async {
    final response = await supabase
        .from('products')
        .select('*')
        .eq('category', widget.categoryName);
    setState(() {
      items = List<Map<String, dynamic>>.from(response as List);
    });
  }

  @override
  void initState() {
    super.initState();
    showItems();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      backgroundColor: AppColors.primary,
      content: SizedBox(
        width: 400,
        height: 500,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card.filled(
                  color: const Color.fromARGB(165, 53, 102, 104),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: const Color.fromARGB(23, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Stock: ${items[index]['stock']}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
