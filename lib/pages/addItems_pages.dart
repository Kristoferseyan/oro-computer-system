// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:orocomputer_system/utils/colors.dart';

class AddItemsPages extends StatelessWidget {
  const AddItemsPages({super.key});

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
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Item Name'),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Price"),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Stock'),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Specifications'),
                    style: Theme.of(context).textTheme.headlineSmall,
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
            child: ElevatedButton(onPressed: (){} , child: Text("Add Item")),
          )
        ],
      ),
    );
  }
}
