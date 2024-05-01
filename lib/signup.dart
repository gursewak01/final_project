import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'widgets/custom_widgets/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController _cPassword = TextEditingController();

  TextEditingController age = TextEditingController();

  TextEditingController gender = TextEditingController();

  Future<void> insertData() async {
    if (name.text != "" || email.text != "" || password.text != "") {
      String uri = "http://localhost:3001/auth/signup";
      var client = http.Client();
      var user_data = {
        "username": name.text,
        "password": password.text,
        "email": email.text,
        "age": int.parse(age.text),
        "gender": gender.text
      };
      var body = json.encode(user_data);
      try {
        var response = await client.post(
          Uri.parse(uri),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        print(response.body);

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

  // String gender = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 14.0),
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          } else if (!value.contains('@')) {
                            return 'Please enter valid Email';
                          }
                          return null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          } else
                            return null;
                        },
                        controller: password,
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
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your confirmed password';
                          }
                          if (value != password.text) {
                            return 'Password not matched';
                          } else
                            return null;
                        },
                        controller: _cPassword,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          return null;
                        },
                        controller: age,
                        decoration: InputDecoration(
                            hintText: "Age",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please specify your gender';
                          }
                          return null;
                        },
                        controller: gender,
                        decoration: InputDecoration(
                            hintText: "Gender",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left:6.0, right: 8),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         "Gender:     ",
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           // fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       Radio(
                      //           value: "male",
                      //           groupValue: gender,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               gender = value.toString();
                      //             });
                      //           }),
                      //       Text("Male"),
                      //       Radio(
                      //           value: "female",
                      //           groupValue: gender,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               gender = value.toString();
                      //             });
                      //           }),
                      //       Text("Female"),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            insertData();
                            const snackdemo = SnackBar(
                              content: Text('Account Successfully Created !'),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackdemo);
                            _formKey.currentState?.reset();
                          }
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.purple,
                        ),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  const Center(child: Text("Or")),
                  const SizedBox(
                    height: 6,
                  ),
                  // Container(
                  //   height: 45,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     border: Border.all(
                  //       color: Colors.purple,
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.white.withOpacity(0.5),
                  //         spreadRadius: 1,
                  //         blurRadius: 1,
                  //         offset: const Offset(
                  //             0, 1), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           height: 30.0,
                  //           width: 30.0,
                  //           decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/login_signup/google.png'),
                  //                 fit: BoxFit.cover),
                  //             shape: BoxShape.circle,
                  //           ),
                  //         ),
                  //         const SizedBox(width: 18),
                  //         const Text(
                  //           "Sign In with Google",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: Colors.purple,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      SizedBox(
                        width: 6,
                      ),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(65)))),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
