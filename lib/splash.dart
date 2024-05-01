import 'package:fitness_app/home.dart';
import 'package:flutter/material.dart';
import 'admin_home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? email = prefs.getString("email");
      // (email==null)?
      Navigator.of(context).pushReplacement
        (MaterialPageRoute(builder: (context)=> LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(194, 237, 239, 1),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 160),
            width: 240,
            height: 240,
            child: Image.asset("assets/images/Myfithealth1.png"),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Developed By", style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),),
                Text("Gursewak", style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),),
              ],
            ),
          ),
        ],
      ),
      
    ));
  }
}
