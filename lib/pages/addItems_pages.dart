// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddItemsPages extends StatefulWidget {
  const AddItemsPages({super.key});

  @override
  State<AddItemsPages> createState() => _AddItemsPagesState();
}


class _AddItemsPagesState extends State<AddItemsPages> {

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemStockController = TextEditingController();
  final TextEditingController itemDescriptionController = TextEditingController();

  void addItem() async{
    String name = itemNameController.text;
    int? price = int.tryParse(itemPriceController.text);
    String description = itemDescriptionController.text;
    int? stock = int.tryParse(itemStockController.text);


    final response = await Supabase.instance.client
    .from('products')
    .insert(
      {
        'name': name,
        'price': price,
        'stock': stock,
        'description': description,
      }
    );

  }
  
  @override
  void dispose(){
    super.dispose();
    itemNameController.dispose();
    itemPriceController.dispose();
    itemStockController.dispose();
    itemDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "Add Items",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Item Name',), style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: itemPriceController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Price"),  style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: itemStockController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Stock'),  style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  TextField(
                    controller: itemDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Specifications'), 
                    style:
                      Theme.of(context).textTheme.headlineSmall,
                      maxLines: 5,
                      minLines: 3,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10, bottom: 10 ),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text("Upload Item Image Here",
                style: TextStyle(
                  color: Colors.white
                ),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 170),
            child: ElevatedButton(onPressed: addItem , child: Text("Add Item")),
          )
        ],
      ),
    );
  }
}
