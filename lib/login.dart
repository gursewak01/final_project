import 'dart:convert';

import 'package:fitness_app/home.dart';
import 'package:fitness_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'admin_login.dart';
import 'widgets/custom_widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errormsg = "";
  bool error = false, showprogress = false;
  String username = "", password = "";

  var _email = TextEditingController();
  var _password = TextEditingController();

  Future<void> startLogin() async {
    // Define your API endpoint
    var apiUrl = "http://localhost:3001/auth/login";
    var client = http.Client();
    var data = {"email": _email.text, "password": _password.text};
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
      print(response.statusCode);
      
      if (response.statusCode == 201) {
      print('Login successful');
      setState(() {
        error = false;
        showprogress = false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
      });
      // Additional logic for successful login
    } else if (response.statusCode == 401) {
      print('Invalid Email or Password');
      setState(() {
        error = true;
        errormsg = "Invalid Email or Password";
      });
      // Additional logic for failed login due to invalid credentials
    } else {
      // Handle other status codes
      print('Failed to validate login data. Error: ${response.statusCode}');
    }

      //third code
      // if (response.statusCode == 201) {
      //   var jsondata = json.decode(response.body);
      //   if (jsondata["success"]) {
      //     print('Login successful');
      //     setState(() {
      //       // error = false;
      //       // showprogress = false;
      //     });
      //   }else {
      //     print('Login failed');
      //     setState(() {
      //       // error = true;
      //       // showprogress = false;
      //       errormsg = jsondata["message"];
      //     });
      //   }
      //   // Additional logic for successful login
      // } else if (response.statusCode == 401) {
      //   print('Invalid username or password');
      //   setState(() {
      //     // error = true;
      //     // errormsg = "Invalid credentials";
      //   });
      //   // Additional logic for failed login due to invalid credentials
      // } else {
      //   // Handle other status codes
      //   print('Failed to validate login data. Error: ${response.statusCode}');
      // }
    } catch (error) {
      // Handle errors from the HTTP request
      print('API connection failed. Error: $error');
    }
  }

  final _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appbar(context),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
              ElevatedButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AdminLogin()));
              }, child: Text("Go to Admin Page")),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            controller: _email,
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.purple.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Password';
              } else if (_password.text != value) {
                return "Password Incorrect";
              }
              return null;
            },
            controller: _password,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_loginKey.currentState!.validate()) {
                startLogin();
              }
              // else{
              //   error = true;
              // }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,

            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              //show error message here
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(4),
              child: error ? errmsg(errormsg) : Container(),
              //if error == true then show error message
              //else set empty container as child
            ),
          ),
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: EdgeInsets.all(15.00),
      margin: EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color: Colors.red, width: 2)),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        //show error message text
      ]),
    );
  }
}
