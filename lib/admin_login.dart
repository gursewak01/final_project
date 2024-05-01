import 'package:flutter/material.dart';

import 'login.dart';

// import 'widgets/custom_widgets/widgets.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();

  
}

class _AdminLoginState extends State<AdminLogin> {
    final _adminloginKey = GlobalKey<FormState>();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    bool err = false;
    String error = "Invalid Credentials";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // leading: IconButton(onPressed: () {
          //   Navigator.of(context).pop();
          // }, icon: Icon(Icons.arrow_back_ios)),
          title: Center(child: Text("Admin Page",)),
          backgroundColor: Colors.purple.shade400,
          foregroundColor: Colors.white,
        ),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              ElevatedButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
              }, child: Text("Go to Member Page")),
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
          "Admin Login",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Text("Enter Admin's credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _adminloginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          err ?Center(
            child: Container(
              margin: EdgeInsets.only(left:0),
              padding: EdgeInsets.all(4),
              child: Text("Invalid Credentials",style: TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold),) ,
            ),
          ):Container(),
          SizedBox(
            height: 20,
          ),
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_adminloginKey.currentState!.validate()){
               String email = _email.text;
               String password = _password.text;

               if (email == 'admin123@gmail.com' && password == 'admin123'){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
               }else{
                setState(() {
                  err=true;
                });
               }
              }else{
                // setState(() {
                //   error = "Invalid Credentials";
                // });
              }
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
          
        ],
      ),
    );
  }
}