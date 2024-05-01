import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/tutorial_model.dart';
import '../widgets/custom_widgets/widgets.dart';

class updateTutorialPage extends StatefulWidget {
  const updateTutorialPage({super.key});

  @override
  State<updateTutorialPage> createState() => _updateTutorialPageState();
}
// class ControllerWithValue extends TextEditingController{
//   TextEditingController name= TextEditingController();
//   Text _value = Text('');
//   ControllerWithValue(this.name,this._value);
// }

class _updateTutorialPageState extends State<updateTutorialPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _videoUrl = TextEditingController();
  TextEditingController _idController = TextEditingController();
  List<String> tutorial_id = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchPosts1();
      update;
    });
  }

  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjgyMjkyNywiZXhwIjoxNzEyOTA5MzI3fQ.k0jn05pk9nNj6l-IiDjyYzERSB4LhC7S_VvIiRh4r8o';
  Future<List<TutorialModel>> fetchPosts1() async {
    var client = http.Client();
    final response = await client.get(
        Uri.parse('http://localhost:3001/tutorial/all-tutorial'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      print("connection success..");
      // print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      // print(data[1]['_id']);
      for (var element in data){
        String id = element['_id'];
        tutorial_id.add(id);
      }
      // print(tutorial_id);
      return data.map((json) => TutorialModel.fromJson(json)).toList();
      // return data.cast<Map<String,dynamic>>();
    } else {
      print(response.body);
      throw Exception("Failed to load posts");
    }
  }

  void refreshData() async{
    try{
      await fetchPosts1();
      print('Data refreshed successfully');
    } catch (e){
      print('Failed to refresh data: $e');
    }
  }

  Future<void> updateTutorial() async {
    if (_title.text != "" || _description.text != "" || _videoUrl.text != "") {
      String uri = "http://localhost:3001/tutorial/${_idController.text}";
      var client = http.Client();
      var tutorial_data = {
        "title": _title.text,
        "description": _description.text,
        "videoUrl": _videoUrl.text,
      };
      var body = json.encode(tutorial_data);
      try {
        var response = await client.put(
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

  bool update = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Admin"),
        actions: [IconButton(onPressed: () {
          setState(() {
            refreshData();
          });
        }, icon: Icon(Icons.refresh))],
        backgroundColor: Colors.purple.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<TutorialModel>>(
            future: fetchPosts1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<TutorialModel> tutorial = snapshot.data!;

                // print(tutorial[0]._tutorialId);
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: BText(
                              "Select the tutorial that you want to update: "),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: double.maxFinite,
                              child: ListView.builder(
                                  itemCount: tutorial.length,
                                  itemBuilder: (BuildContext context, index) {
                                    // final dataIndex = index + 8;
                                    return Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(16),
                                        height: 104,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color.fromARGB(
                                                255, 16, 133, 228),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(28))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 120,
                                              child: TText(
                                                  "${tutorial[index].title}"),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: 16, left: 10),
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      // print(tutorial_id);
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SingleChildScrollView(
                                                            child: AlertDialog(
                                                              content: SingleChildScrollView(
                                                                child: Form(
                                                                  key: _formKey,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                       SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      MText(
                                                                          'Tutorial ID: '),
                                                                      TextFormField(
                                                                        enabled: false,
                                                                        controller:
                                                                            _idController =
                                                                                TextEditingController(text: '${tutorial_id[index]}'),
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                        maxLines:
                                                                            null,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          // prefixText: '${tutorial[index].title}',
                                                                          hintText:
                                                                              "Tutorial ID",
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(18),
                                                                              borderSide: BorderSide.none),
                                                                          fillColor: Colors
                                                                              .purple
                                                                              .withOpacity(0.1),
                                                                          filled:
                                                                              true,
                                                                          // prefixIcon:
                                                                          //     const Icon(
                                                                          //         Icons.title),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      MText(
                                                                          'Title: '),
                                                                      TextFormField(
                                                                        validator:
                                                                            (value) {
                                                                          if (value ==
                                                                                  null ||
                                                                              value.isEmpty) {
                                                                            return 'Please enter title';
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller:
                                                                            _title =
                                                                                TextEditingController(text: '${tutorial[index].title}'),
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                        maxLines:
                                                                            null,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          // prefixText: '${tutorial[index].title}',
                                                                          hintText:
                                                                              "Title",
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(18),
                                                                              borderSide: BorderSide.none),
                                                                          fillColor: Colors
                                                                              .purple
                                                                              .withOpacity(0.1),
                                                                          filled:
                                                                              true,
                                                                          // prefixIcon:
                                                                          //     const Icon(
                                                                          //         Icons.title),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      MText(
                                                                        'Description: ',
                                                                      ),
                                                                      TextFormField(
                                                                        validator:
                                                                            (value) {
                                                                          if (value ==
                                                                                  null ||
                                                                              value.isEmpty) {
                                                                            return 'Please enter description';
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller:
                                                                            _description =
                                                                                TextEditingController(text: '${tutorial[index].description}'),
                                                                        //  initialValue: '${tutorial[index].description}',
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                        maxLines:
                                                                            null,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          // prefixText: '${tutorial[index].title}',
                                                                          hintText:
                                                                              "Description",
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(18),
                                                                              borderSide: BorderSide.none),
                                                                          fillColor: Colors
                                                                              .purple
                                                                              .withOpacity(0.1),
                                                                          filled:
                                                                              true,
                                                                          // prefixIcon:
                                                                          //     const Icon(
                                                                          //         Icons.title),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      MText(
                                                                        'Video URL:',
                                                                      ),
                                                                      TextFormField(
                                                                        validator:
                                                                            (value) {
                                                                          if (value ==
                                                                                  null ||
                                                                              value.isEmpty) {
                                                                            return 'Please enter video URL';
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller:
                                                                            _videoUrl =
                                                                                TextEditingController(text: '${tutorial[index].videoUrl}'),
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                        maxLines:
                                                                            null,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          // prefixText: '${tutorial[index].title}',
                                                                          hintText:
                                                                              "Video URL",
                                                                          border: OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(18),
                                                                              borderSide: BorderSide.none),
                                                                          fillColor: Colors
                                                                              .purple
                                                                              .withOpacity(0.1),
                                                                          filled:
                                                                              true,
                                                                          // prefixIcon:
                                                                          //     const Icon(
                                                                          //         Icons.title),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Center(
                                                                        child: ElevatedButton(
                                                                            onPressed: () {
                                                                              if (_formKey.currentState!.validate()) {
                                                                                updateTutorial();
                                                                                refreshData();
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                  content: Text('Updated Successfully !'),
                                                                                  backgroundColor: Colors.green,
                                                                                  elevation: 10,
                                                                                  behavior: SnackBarBehavior.floating,
                                                                                  margin: EdgeInsets.all(5),
                                                                                )
                                                                                );
                                                                                
                                                                                Navigator.of(context).pop();
                                                                              } else {}
                                                                            },
                                                                            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purple.shade400), foregroundColor: MaterialStatePropertyAll(Colors.white)),
                                                                            child: Text("Update")),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Close'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          Color.fromARGB(
                                                              255, 9, 105, 184),
                                                      backgroundColor:
                                                          Colors.white,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 26,
                                                              vertical: 15),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      elevation: 5,
                                                    ),
                                                    child: Text("Select")))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ))
                          ],
                        ),
                      ],
                    ));
              }
            }),
      ),
    );
  }
}
