// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:orocomputer_system/components/item_dialog_box.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;

//---------------------------LISTS--------------------------------------------//

  //List for prudct items
  List<dynamic> products = [];

  void fetchProducts() async {
    final response = await supabase.from('products').select('*');

    setState(() {
      products = response;
    });
  }

  //List for category name and icons
  List<Map<String, dynamic>> components = [
    {"name": "CPU", "icon": Icons.developer_board},
    {"name": "GPU", "icon": Icons.graphic_eq},
    {"name": "RAM", "icon": Icons.memory},
    {"name": "Motherboard", "icon": Icons.settings_applications},
    {"name": "Storge", "icon": Icons.storage},
    {"name": "Laptop", "icon": Icons.laptop},
    {"name": "Accessories", "icon": Icons.headphones},
    {"name": "Printer", "icon": Icons.print},
  ];

//---------------------------END-LISTS--------------------------------------------//

//---------------------------METHODS--------------------------------------------//
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Function when an item is selected
  void selectItem(Map<String, dynamic> product) {
    showDialog(
        context: context,
        builder: (context) {
          return ItemDialogBox(
            itemName: product['name'].toString(),
          );
        });
  }
//---------------------------END-METHODS--------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                "Search Bar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          // Title Section
          Text(
            "Available Stocks",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),

          // Main Content Section
          Expanded(
            child: Row(
              children: [
                // Left Side Box - Category Section
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 20),
                  child: Container(
                    width: 300, 
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 62, 76, 76),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 14, top: 8),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            itemCount: components.length,
                            itemBuilder: (context, index) {
                              final category = components[index];
                              return GestureDetector(
                                onTap: () {
                                  print(
                                      "Selected category: ${category['name']}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        category['icon'],
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        category['name'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Side Box - Item Section
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () => selectItem(product),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.box,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 14, bottom: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${product['name']}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "₱${product['price']}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Stock Remaining: ${product['stock']}",
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
