import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class test1 extends StatefulWidget {
  const test1({super.key});

  @override
  State<test1> createState() => _test1State();
}

class _test1State extends State<test1> {

  Future<void> checkApiConnection() async {
    // Define your API endpoint
    var apiUrl = "http://localhost:3001/auth/login";
    var client = http.Client();
    var data = 
    {
      "email": "suraj1@gmail.com", 
      "password": "suraj123"
    };
    var body = json.encode(data);
    try {
      // Make a GET request to the API endpoint
      var response = await client.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      print(response.body);
      // Check if the request was successful (status code 200)
      // if (response.statusCode == 200) {
      //   print('API connection successful');
      // } else {
      //   // Handle other status codes
      //   print('API connection failed. Status code: ${response.statusCode}');
      // }
    } catch (error) {
      // Handle errors from the HTTP request
      print('API connection failed. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: checkApiConnection, child: Text("Test me!")),
        ),
      ),
    );
  }
}
