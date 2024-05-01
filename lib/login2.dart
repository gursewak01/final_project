// import 'dart:convert';

// import 'package:fitness_app/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'widgets/custom_widgets/widgets.dart';

// class LoginPage2 extends StatefulWidget {
//   const LoginPage2({super.key});

//   @override
//   State<LoginPage2> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage2> {
  
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();


// //original login code
//   Future<void> startLogin() async {
//     // Define your API endpoint
//     var apiUrl = "http://localhost:3001/auth/login";
//     var client = http.Client();
//     var data = 
//     {
//       "email": _email.text, 
//       "password": _password.text
//     };
//     var body = json.encode(data);
//     try {
//       // Make a GET request to the API endpoint
//       var response = await client.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: body,
//       );
//       print(response.body);
//       if (response.statusCode == 200) {
//       var jsondata = json.decode(response.body);
//       if (jsondata["error"]) {
//         setState(() {
//           showprogress = false; //don't show progress indicator
//           error = true;
//           errormsg = jsondata["message"];
//         });
//       } else {
//         if (jsondata["success"]) {
//           setState(() {
//             error = false;
//             showprogress = false;
//           });
//         } else {
//           showprogress = false; //don't show progress indicator
//           error = true;
//           errormsg = "Something went wrong.";
//         }
//       }
//     } else {
//       setState(() {
//         showprogress = false; //don't show progress indicator
//         error = true;
//         errormsg = "Error during connecting to server.";
//       });
//     }

//     } catch (error) {
//       // Handle errors from the HTTP request
//       print('API connection failed. Error: $error');
//     }
  
//   }

//   //second code
//   Future<void> _login() async {
//     final String apiUrl = 'http://localhost:81/UserData_api/login.php';
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         'username': _usernameController.text,
//         'password': _passwordController.text,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       if (responseData['success'] == true) {
//         // Login successful
//         print('Login successful');
//         // Navigate to next screen or perform desired action
//       } else {
//         // Login failed
//         print('Login failed: ${responseData['message']}');
//         // Show error message or perform any other action
//       }
//     } else {
//       // Request failed
//       print('Failed to login: ${response.statusCode}');
//       // Show error message or perform any other action
//     }
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: appbar(context),
//         body: Container(
//           margin: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _header(context),
//               _inputField(context),
//               _forgotPassword(context),
//               _signup(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _header(context) {
//     return Column(
//       children: [
//         Text(
//           "Welcome Back",
//           style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//         ),
//         Text("Enter your credential to login"),
//       ],
//     );
//   }

//   _inputField(context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         TextField(
//           controller: _usernameController,
//           decoration: InputDecoration(
//               hintText: "Username",
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none),
//               fillColor: Colors.purple.withOpacity(0.1),
//               filled: true,
//               prefixIcon: const Icon(Icons.person)),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _passwordController,
//           decoration: InputDecoration(
//             hintText: "Password",
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(18),
//                 borderSide: BorderSide.none),
//             fillColor: Colors.purple.withOpacity(0.1),
//             filled: true,
//             prefixIcon: const Icon(Icons.password),
//           ),
//           obscureText: true,
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             _login();
//           },
//           style: ElevatedButton.styleFrom(
//             shape: const StadiumBorder(),
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             backgroundColor: Colors.purple,
//           ),
//           child: const Text(
//             "Login",
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         // Container(
//         //   //show error message here
//         //   margin: EdgeInsets.only(top: 30),
//         //   padding: EdgeInsets.all(10),
//         //   child: error ? errmsg(errormsg) : Container(),
//         //   //if error == true then show error message
//         //   //else set empty container as child
//         // ),
//       ],
//     );
//   }

//   _forgotPassword(context) {
//     return TextButton(
//       onPressed: () {},
//       child: const Text(
//         "Forgot password?",
//         style: TextStyle(color: Colors.purple),
//       ),
//     );
//   }

//   _signup(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Dont have an account? "),
//         TextButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (context) => SignupPage()));
//             },
//             child: const Text(
//               "Sign Up",
//               style: TextStyle(color: Colors.purple),
//             ))
//       ],
//     );
//   }

//     Widget errmsg(String text){
//   //error message widget.
//         return Container(
//             padding: EdgeInsets.all(15.00),
//             margin: EdgeInsets.only(bottom: 10.00),
//             decoration: BoxDecoration( 
//                borderRadius: BorderRadius.circular(30),
//                color: Colors.red,
//                border: Border.all(color:Colors.red, width:2)
//             ),
//             child: Row(children: <Widget>[
//                 Container(
//                     margin: EdgeInsets.only(right:6.00),
//                     child: Icon(Icons.info, color: Colors.white),
//                 ), // icon for error message
                
//                 Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
//                 //show error message text
//             ]),
//         );
//   }
// }
