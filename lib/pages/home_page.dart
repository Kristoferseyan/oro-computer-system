// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:orocomputer_system/components/item_dBox.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {
  String connectionError = '_ClientSocketException'; 
  final supabase = Supabase.instance.client;
    int selectedCategoryIndex = -1;



//---------------------------LISTS--------------------------------------------//

  //List for prudct items
  List<dynamic> products = [];

  //List for category name and icons
  List<Map<String, dynamic>> components = [
    {"name": "CPU", "icon": Icons.developer_board},
    {"name": "GPU", "icon": Icons.graphic_eq},
    {"name": "RAM", "icon": Icons.memory},
    {"name": "Motherboard", "icon": Icons.settings_applications},
    {"name": "Storage", "icon": Icons.storage},
    {"name": "Laptop", "icon": Icons.laptop},
    {"name": "Accessories", "icon": Icons.headphones},
    {"name": "Printer", "icon": Icons.print},
  ];

//---------------------------END-LISTS--------------------------------------------//

//---------------------------METHODS--------------------------------------------//
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }
  // Method to fetch all products from database
  void fetchAllProducts() async {
  try{
    final response = await supabase.from('products').select('*');
    if(response != connectionError){
      setState(() {
        products = response;
        selectedCategoryIndex = -1;
      });
    }
  } catch(error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data can't be fetched. No internet connection."))
    );
  }
  
  }

  

  void fetchSelectedCategory() async {
    final selectedCategoryName = components[selectedCategoryIndex]['name'];
    try{
      final response = await supabase.from('products').select('*').eq('category', selectedCategoryName);
      if(response != connectionError){
        setState(() {
          products = response;
        });
      }
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data can't be fetched. No internet connection."))
      );
    }

  }

  // Method when an item is selected
  void selectItem(Map<String, dynamic> product) {
    showDialog(
        context: context,
        builder: (context) {
          return ItemDialogBox(
            itemName: product['name'].toString(),
            itemSpecs: product['description'].toString(),
            itemStock: product['stock'].toString(),
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
          SizedBox(height: 20,),

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
                          child: Row(
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.box
                                  ),
                                  onPressed: fetchAllProducts, 
                                  child: Text("All", style: TextStyle(color: Colors.black),)),
                              )
                            ],
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
                              bool isSelected = selectedCategoryIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState((){
                                    selectedCategoryIndex = index;
                                  });
                                  fetchSelectedCategory();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.black26 : Colors.black38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        category['icon'],
                                        size: 30,
                                        color: isSelected ? Colors.white : const Color.fromARGB(255, 187, 187, 187),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        category['name'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal ,
                                          color: isSelected ? Colors.white : const Color.fromARGB(255, 187, 187, 187) ,
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
class ErrorMessage implements Exception {
  final String message;
  ErrorMessage(this.message);

  @override
  String toString() => 'Error: $message';
}
