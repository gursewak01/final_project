import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitness_app/widgets/custom_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddTutorialPage extends StatefulWidget {
  const AddTutorialPage({super.key});

  @override
  State<AddTutorialPage> createState() => _AddTutorialPageState();
}

class _AddTutorialPageState extends State<AddTutorialPage> {
  String dropdownValue = 'Yoga';
  List<String> tutorial_category = [
    "Yoga",
    "Exercise",
    "Underweight",
    "Healthy",
    "Overweight",
    "Obese"
  ];
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _videoUrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjczNjMyNywiZXhwIjoxNzEyODIyNzI3fQ.Q3dz9wvQgfH0fIJjhvyAHbJAiE-nDglg6I7FLhlkemM';
   Future<void> addTutorial() async {
    if (_title.text != "" || _description.text != "" || _videoUrl.text != "") {
      String uri = "http://localhost:3001/tutorial/add-tutorial";
      var client = http.Client();
      var tutorial_data = {
        "title": dropdownValue.toLowerCase()+':'+_title.text,
        "description": _description.text,
        "videoUrl": _videoUrl.text,
      };
      var body = json.encode(tutorial_data);
      try {
        var response = await client.post(
          Uri.parse(uri),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
          body: body,
        );
        print(response.body);

      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Admin"),
        backgroundColor: Colors.purple.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(child: BText("Add New Tutorial ")),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MText("Select category to add new tutorial in:"),
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            items: tutorial_category
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Colors.purple.shade50,
                            style: TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        MText("Title of new Tutorial:"),
                        TextFormField(
                          controller: _title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Title",
                            prefixText: dropdownValue.toLowerCase()+':',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.title),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MText("Description:"),
                        TextFormField(
                          controller: _description,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.description),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MText("Video URL :"),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please specify URL';
                            }
                            return null;
                          },
                          controller: _videoUrl,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "URL of Tutorial video",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.description),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()){
                                addTutorial();
                                const snackdemo = SnackBar(
                              content: Text('Tutorial added Successfully !'),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackdemo);
                            // _formKey.currentState?.reset();
                              }else {
                                print(dropdownValue.toLowerCase()+':');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 80, right: 80, top: 6, bottom: 6),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
