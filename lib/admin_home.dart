import 'package:flutter/material.dart';

import 'admin/add_tutorial.dart';
import 'admin/delete_tutorial.dart';
import 'admin/update_tutorial.dart';
import 'admin/view_tutorial.dart';
import 'widgets/custom_widgets/widgets.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Welcome to ADMIN")),
          backgroundColor: Colors.purple.shade400,
          foregroundColor: Colors.white,
        ),
        body: Container(
          height: 520, // Adjust the height as needed
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(6),
                child: BText("Select the activity you prefer to take from below:"),),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewTutorialPage()));
                    },
                    child: Card(
                      color: Colors.blue.shade400,
                      elevation: 4,
                      child: Container(
                        width: double.infinity, // Full width
                        height: double.infinity, // Full height
                        child: Center(
                          child: Text(
                            'View All Tutorials',
                          style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
                                    
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddTutorialPage()));
                    },
                    child: Card(
                      color: Colors.blue.shade400,
                      elevation: 4,
                      child: Container(
                        width: double.infinity, // Full width
                        height: double.infinity, // Full height
                        child: Center(
                          child: Text(
                            'Add New Tutorial',
                          style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
                                    
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8), // Adjust spacing between cards
                Expanded(
                  child: InkWell(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> updateTutorialPage()));
                    },
                    child: Card(
                      color: Colors.blue.shade400,
                      elevation: 4,
                      child: Container(
                        width: double.infinity, // Full width
                        height: double.infinity, // Full height
                        child: Center(
                          child: Text(
                            'Update Existing Tutorial',
                                 style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
                    
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8), // Adjust spacing between cards
                Expanded(
                  child: InkWell(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DeleteTutorialPage()));
                    },
                    child: Card(
                      color: Colors.blue.shade400,
                      elevation: 4,
                      child: Container(
                        width: double.infinity, // Full width
                        height: double.infinity, // Full height
                        child: Center(
                          child: Text(
                            'Delete Tutorial',
                            style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
