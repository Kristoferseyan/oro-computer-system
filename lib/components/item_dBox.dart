// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemDialogBox extends StatefulWidget {
  final String itemName;
  final String itemID;
  final String itemSpecs;
  final String itemStock;

  const ItemDialogBox(
      {super.key, required this.itemID ,required this.itemSpecs, required this.itemName, required this.itemStock});

  @override
  State<ItemDialogBox> createState() => _ItemDialogBoxState();
}



class _ItemDialogBoxState extends State<ItemDialogBox> {



  final supabase = Supabase.instance.client;

  //---------------------------CONTROLLERS--------------------------------------------//
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController noOfItemsController = TextEditingController();

  //---------------------------CONTROLLERS--------------------------------------------//

  //---------------------------METHODS--------------------------------------------//

  List<Map<String, dynamic>> items = [];


  void fetchAllItems() async {
    final response = await supabase.from('products').select("*");
    setState(() {
      items = response;
    });
  }

  @override
  void initState() {
    fetchAllItems();
    super.initState();
  }

  void buyBtn(){

  }

  void cancelBtn(){

  }

  void delItem() async{
    await supabase
      .from('products')
      .delete()
      .eq('id', widget.itemID);
    Navigator.pop(context);
    fetchAllItems();
  }
  //---------------------------END-METHODS--------------------------------------------//

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: AppColors.primary,
      content: SizedBox(
        width: 600, 
        height: 300, 
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
                    delItem();
                    print("Item is deleted");
                  },
                  icon: Icon(Icons.delete),
                  color: Color.fromARGB(255, 115, 50, 50),
                ),
              ],
            ),
            Text(
              "Specifications: ${widget.itemSpecs}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5,),
            Text(
              "Stock Count: ${widget.itemStock} items",
              style: TextStyle(fontSize: 18),
            ),
            Divider(color: Colors.black),

            SizedBox(
              width: 400,
              child: TextField(
                controller: buyerNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name of buyer"
                ),
              ),
            ),
            
            SizedBox(height: 8,),

            SizedBox(
              width: 200,
              child: TextField(
                controller: noOfItemsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "No. of Items"
                ),
              ),
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      fixedSize: Size(100, 40)
                    ), 
                  child: Text("Buy", 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                
                SizedBox(width: 10,),

                ElevatedButton(
                  onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cancel,
                      fixedSize: Size(100, 40)
                    ), 
                  child: Text("Cancel", 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
