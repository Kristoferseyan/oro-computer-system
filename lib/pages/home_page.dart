// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final supabase = Supabase.instance.client;

    List<dynamic> products = [];


    void fetchProducts() async {
    final response = await supabase
      .from('products')
      .select();

      setState(() {
        products = response;
      });
  }

    @override
    void initState() {
      super.initState();
      fetchProducts();
    }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              child: Center(
                child: Text(
                  "Search Bar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(child: GridView.builder(
            padding: EdgeInsets.only(left: 10, right: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
              ), 
              
              itemCount: products.length,

              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.box,
                    borderRadius: BorderRadius.circular(20)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${product['name']}" ),
                        Text("₱${product['price']}"),
                        Text("Stock Remaining: ${product['stock']}",)
                      ],
                    ),
                  )
                );
              }))
        ],
      ),
    );
  }
}
