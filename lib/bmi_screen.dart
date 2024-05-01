import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'recommendations.dart';
import 'widgets/custom_widgets/widgets.dart';

class BMI_Screen_Page extends StatefulWidget {
  const BMI_Screen_Page({super.key});
  //  final String bmi;

  @override
  State<BMI_Screen_Page> createState() => _BMI_Screen_PageState();
}

class _BMI_Screen_PageState extends State<BMI_Screen_Page> {

  bool showWidget = false;

  String gender = "";
  String height = "";
  String weight = "";
  double bmi = 0;
  String finalBMI = "";
  String status = "";
  // String finalStatus = "";
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _finalStatus = TextEditingController();

  double finalHeight = 0;
  double finalWeight = 0;

  calculate() {
    height = _height.text;
    weight = _weight.text;

    if (defaultHeightType == 'feet') {
      finalHeight = (double.parse(height) * 30.48);
    }
    if (defaultWeightType == 'pounds') {
      finalWeight = (double.parse(weight) * 0.4535);
    }
    if (defaultHeightType == 'cm') {
      finalHeight = (double.parse(height));
    }
    if (defaultWeightType == 'kgs') {
      finalWeight = (double.parse(weight));
    }

    bmi = (finalWeight / (finalHeight * finalHeight)) * 10000;

    if (bmi >= 18.5 && bmi <= 24.9) {
      status = "Healthy";
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      status = "Overweight";
    } else if (bmi >= 30.0) {
      status = "Obese";
    } else if (bmi < 18.5) {
      status = "Underweight";
    } else {
      status = "";
    }
    setState(() {
      finalBMI = bmi.toInt().toString();
      _finalStatus.text = status;
    });
  }

  final _BMIkey = GlobalKey<FormState>();

  String defaultHeightType = 'feet';
  var height_types = ['feet', 'cm'];

  String defaultWeightType = 'kgs';
  var weight_types = ['kgs', 'pounds'];
  DateTime today = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjczNjMyNywiZXhwIjoxNzEyODIyNzI3fQ.Q3dz9wvQgfH0fIJjhvyAHbJAiE-nDglg6I7FLhlkemM';
  Future<void> insertBMI() async {
    if (_height.text != "" || _weight.text != "") {
      String uri = "http://localhost:3001/bmi-record/add-bmi-record";
      var client = http.Client();
      var user_bmi = {
        // "userId": name.text,
        "bmi": finalBMI,
        "date": '${formattedDate}',
      };
      var body = json.encode(user_bmi);
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
        print('${formattedDate}');

        // if (response["message"] == "true") {
        //   print("Record Inserted");
        // } else {
        //   print("some issue");
        //   print(response);
        // }
      } catch (e) {
        print(e);
      }
    } else {
      print("please fill all");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 224, 220, 220),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Icon(
                  Icons.calculate,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "BMI Calculator",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            height: 500,
            width: 305,
            // color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5, bottom: 0),
              child: Form(
                key: _BMIkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MText("Hi Gursewak!"),
                      BText("Calculate your BMI"),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Text(
                            "Gender:           ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              }),
                          Text("Male"),
                          Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              }),
                          Text("Female"),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Height in (ft/cm): ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 190,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9-.]"))
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Height';
                                }
                                return null;
                              },
                              controller: _height,
                              decoration: InputDecoration(
                                  hintText: "Enter your Height",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.purple.withOpacity(0.1),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.height)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 70,
                            child: DropdownButton(
                                style: TextStyle(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                focusColor: Colors.purple.withOpacity(0.1),
                                value: defaultHeightType,
                                items: height_types.map((String height_types) {
                                  return DropdownMenuItem(
                                      value: height_types,
                                      child: Text(height_types));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    defaultHeightType = newValue!;
                                  });
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Weight in (kgs/pounds): ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 190,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9-.]"))
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Weight';
                                }
                                return null;
                              },
                              controller: _weight,
                              decoration: InputDecoration(
                                  hintText: "Enter your Weight",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.purple.withOpacity(0.1),
                                  filled: true,
                                  prefixIcon:
                                      const Icon(Icons.line_weight_outlined)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton(
                              style: TextStyle(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              focusColor: Colors.purple.withOpacity(0.1),
                              value: defaultWeightType,
                              items: weight_types.map((String weight_types) {
                                return DropdownMenuItem(
                                    value: weight_types,
                                    child: Text(weight_types));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  defaultWeightType = newValue!;
                                });
                              })
                        ],
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Color.fromARGB(221, 74, 24, 255),
                            ),
                            onPressed: () {
                              if (_BMIkey.currentState!.validate()) {
                                calculate();
                                showWidget = true;
                                insertBMI();
                                
                              }
                            },
                            child: Text("Calculate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      showWidget? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Your BMI: $finalBMI",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text("Status: ${_finalStatus.text}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                      SizedBox(
                        height: 12,
                      ),
                      showWidget? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Recommendations(BMI_Status: _finalStatus.text,)));
                          },
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(90), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(90))))
                          ),
                          child: MText("Our Recommendations for You  >")): Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
