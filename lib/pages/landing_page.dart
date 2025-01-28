// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orocomputer_system/utils/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}



class _LandingPageState extends State<LandingPage> {
  final TextEditingController codeController = TextEditingController();
  final String masterCode = "0214";

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/Oro.png') 
            ),
            
            SizedBox(
              width: 500,
              child: TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                controller: codeController,
                decoration: InputDecoration(
                  labelText: "Enter user code",
                  labelStyle: TextStyle(color: const Color.fromARGB(116, 255, 255, 255)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ) ,
                
              ),
            ),
      
            SizedBox(height: 20,),
      
            ElevatedButton(
              onPressed: (){
                if(codeController.text != masterCode){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect code!")));
                }else{
                  Navigator.pushNamed(context, '/dashboard');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ), 
              child: Text(
                "Dashboard",
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),)
        ],
      ), 
    );
  }
}
