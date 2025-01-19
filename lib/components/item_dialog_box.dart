import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemDialogBox extends StatefulWidget {
  final String itemName;
  const ItemDialogBox({super.key, required this.itemName});

  @override
  State<ItemDialogBox> createState() => _ItemDialogBoxState();
}

class _ItemDialogBoxState extends State<ItemDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        width: 200,
        child: Text(widget.itemName, 
          style: TextStyle(fontSize: 20, ),),
      ),
    );
  }
}