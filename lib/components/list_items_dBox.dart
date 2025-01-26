import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListItemsDialogBox extends StatefulWidget {
  final String itemName;
  final String itemStock;

  const ListItemsDialogBox(
      {super.key, required this.itemName, required this.itemStock});

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
        .eq('category', widget.itemName);
    setState(() {
      items = List<Map<String, dynamic>>.from(response as List);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      content: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index]['name'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Stock: ${items[index]['stock']}",
                style: TextStyle(color: Colors.white70),
              ),
            );
          },
        ),
      ),
    );
  }
}
