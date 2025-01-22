// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddItemsPage extends StatefulWidget {
  const AddItemsPage({Key? key}) : super(key: key);

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  //---------------------------CONTROLLERS--------------------------------------------//
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemStockController = TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();

  //---------------------------CATEGORIES--------------------------------------------//
  final List<Map<String, dynamic>> categories = [
    {"name": "CPU", "icon": Icons.developer_board},
    {"name": "GPU", "icon": Icons.graphic_eq},
    {"name": "RAM", "icon": Icons.memory},
    {"name": "Motherboard", "icon": Icons.settings_applications},
    {"name": "Storage", "icon": Icons.storage},
    {"name": "Laptop", "icon": Icons.laptop},
    {"name": "Accessories", "icon": Icons.headphones},
    {"name": "Printer", "icon": Icons.print},
  ];
  String? selectedCategory;

  //---------------------------METHODS--------------------------------------------//
  void addItem() async {
    String name = itemNameController.text.trim();
    int? price = int.tryParse(itemPriceController.text.trim());
    int? stock = int.tryParse(itemStockController.text.trim());
    String description = itemDescriptionController.text.trim();

    if (name.isEmpty ||
        price == null ||
        stock == null ||
        description.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fill in all fields and select a category")),
      );
      return;
    }

    final response = await Supabase.instance.client.from('products').insert({
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
      'category': selectedCategory,
    });

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Error adding item: ${response.error!.message}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item added successfully!")),
      );
      clearFields();
    }
  }

  void clearFields() {
    itemNameController.clear();
    itemPriceController.clear();
    itemStockController.clear();
    itemDescriptionController.clear();
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemPriceController.dispose();
    itemStockController.dispose();
    itemDescriptionController.dispose();
    super.dispose();
  }

  //---------------------------END-METHODS--------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 970),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(167, 53, 102, 104),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Add Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                buildTextField("Item Name", itemNameController),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: buildTextField("Price", itemPriceController,
                          keyboardType: TextInputType.number),
                    ),

                    SizedBox(width: 16),
                    
                    Expanded(
                      child: buildTextField("Stock", itemStockController,
                          keyboardType: TextInputType.number),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                buildTextField(
                  "Specifications",
                  itemDescriptionController,
                  maxLines: 5,
                ),

                SizedBox(height: 20),

                Text(
                  "Select Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      bool isSelected = category['name'] == selectedCategory;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category['name'];
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(177, 167, 199, 200)
                                : const Color.fromARGB(107, 167, 199, 200),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : Colors.grey,
                              width: 1,
                            ),
                          ),

                          child: Row(
                            children: [
                              Icon(category['icon'],
                                  color: isSelected
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          101, 255, 255, 255),
                                  size: 20),
                              SizedBox(width: 8),
                              Text(
                                category['name'],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          101, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Image upload clicked")),
                    );
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(177, 167, 199, 200),
                    ),
                    child: Center(
                      child: Text(
                        "Upload Item Image Here",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: addItem,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Add Item",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        filled: true,
        fillColor: const Color.fromARGB(177, 167, 199, 200),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
