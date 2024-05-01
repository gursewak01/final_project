import 'package:flutter/material.dart';

import 'bmi_screen.dart';
import 'home1.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: buttonIndex,
        onTap: (val){
          setState(() {
            buttonIndex = val;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined), label: 'BMI Calculator'),

      ]),
        body: (buttonIndex == 0) ? HomePage1(): BMI_Screen_Page(),
      ),
    );
  }
}
