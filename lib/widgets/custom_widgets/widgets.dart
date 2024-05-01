import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/tutorial_model.dart';

appbar(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.purple.shade400,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.fitness_center_rounded,
            color: Colors.amber.shade200,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "MyFitHealth",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.directions_run,
            size: 26,
            color: Colors.amber.shade200,
          ),
        ),
      ],
    ),
  );
}

class fetchData{
  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjY2NDIwNSwiZXhwIjoxNzEyNzUwNjA1fQ.Xl-mc6cInYzvCNWaZBn5nqGPE0l_6d3baGekTUPYXeo';
  Future<List<TutorialModel>> fetchPosts() async {
    var client = http.Client();
    final response = await client.get(
        Uri.parse('http://localhost:3001/tutorial/all-tutorial'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      print("connection success");
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TutorialModel.fromJson(json)).toList();
    } else {
      print(response.body);
      throw Exception("Failed to load posts");
    }
  }
}

BText(context) {
  return Text(context, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22));
}

MText(context) {
  return Text(context, style: TextStyle(color: Colors.black, fontSize: 15));
}

TText(context){
  return Text(context,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),);
}

PointText(context){
  return Text(context, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),);
}

// tutorial_recommendation(){
//   if (widget.BMI_Status == "Underweight"){
//     return Row(
//                         children: [
//                           Expanded(
//                               child: SizedBox(
//                             height: 300,
//                             child: ListView.builder(
//                                 itemCount: tutorial.length > 8
//                                         ? tutorial.length - 8
//                                         : 0,
//                                 itemBuilder: (BuildContext context, index) {
//                                    final dataIndex = index + 8;
//                                   return Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(16),
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           color: Color.fromARGB(
//                                               255, 16, 133, 228),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(28))),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("title"),
//                                           Container(
//                                             padding: EdgeInsets.only(top:16),
//                                             alignment: Alignment.bottomRight,
//                                               child: ElevatedButton(
//                                                   onPressed: () {
//                                                     showDialog(
//                                               context: context,
//                                               barrierDismissible: false,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                     title: Text(
//                                                         '${tutorial[dataIndex].title}'),
//                                                     content: Column(
//                                                       children: [
//                                                         Text(
//                                                           '${tutorial[dataIndex].description}',
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         YoutubePlayer(
//                                                           controller:
//                                                               YoutubePlayerController(
//                                                             initialVideoId:
//                                                                 '${tutorial[dataIndex].videoUrl}',
//                                                             flags:
//                                                                 YoutubePlayerFlags(
//                                                                     autoPlay: true,
//                                                                     mute: false),
//                                                           ),
//                                                           showVideoProgressIndicator:
//                                                               true,
//                                                           progressIndicatorColor:
//                                                               Colors.blueAccent,
//                                                         ),
                                                      
//                                                         FloatingActionButton(
//                                                             onPressed: () {
//                                                           setState(() {
//                                                             if (_controller
//                                                                 .value.isPlaying) {
//                                                               _controller.pause();
//                                                             } else {
//                                                               _controller.play();
//                                                             }
//                                                           });
//                                                         }),
//                                                         Icon(_controller
//                                                                 .value.isPlaying
//                                                             ? Icons.pause
//                                                             : Icons.play_arrow)
//                                                       ],
//                                                     ),
//                                                     actions: <Widget>[
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text('Close'),
//                                                       ),
//                                                     ],
//                                                   );
                                                
//                                               },
//                                             );
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     foregroundColor: Color.fromARGB(255, 9, 105, 184), backgroundColor: Colors.white,
//                                                     padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10.0),
//                                                     ),
//                                                     elevation: 5,
//                                                   ),
//                                                   child: Text("Try")))
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ))
//                         ],
//                       );
//   }else if (widget.BMI_Status == "Healthy"){
//     return Row(
//                         children: [
//                           Expanded(
//                               child: SizedBox(
//                             height: 300,
//                             child: ListView.builder(
//                                 itemCount: tutorial.length > 10
//                                         ? tutorial.length - 10
//                                         : 0,
//                                 itemBuilder: (BuildContext context, index) {
//                                    final dataIndex = index + 10;
//                                   return Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(16),
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           color: Color.fromARGB(
//                                               255, 16, 133, 228),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(28))),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("title"),
//                                           Container(
//                                             padding: EdgeInsets.only(top:16),
//                                             alignment: Alignment.bottomRight,
//                                               child: ElevatedButton(
//                                                   onPressed: () {
//                                                     showDialog(
//                                               context: context,
//                                               barrierDismissible: false,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                     title: Text(
//                                                         '${tutorial[dataIndex].title}'),
//                                                     content: Column(
//                                                       children: [
//                                                         Text(
//                                                           '${tutorial[dataIndex].description}',
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         YoutubePlayer(
//                                                           controller:
//                                                               YoutubePlayerController(
//                                                             initialVideoId:
//                                                                 '${tutorial[dataIndex].videoUrl}',
//                                                             flags:
//                                                                 YoutubePlayerFlags(
//                                                                     autoPlay: true,
//                                                                     mute: false),
//                                                           ),
//                                                           showVideoProgressIndicator:
//                                                               true,
//                                                           progressIndicatorColor:
//                                                               Colors.blueAccent,
//                                                         ),
                                                      
//                                                         FloatingActionButton(
//                                                             onPressed: () {
//                                                           setState(() {
//                                                             if (_controller
//                                                                 .value.isPlaying) {
//                                                               _controller.pause();
//                                                             } else {
//                                                               _controller.play();
//                                                             }
//                                                           });
//                                                         }),
//                                                         Icon(_controller
//                                                                 .value.isPlaying
//                                                             ? Icons.pause
//                                                             : Icons.play_arrow)
//                                                       ],
//                                                     ),
//                                                     actions: <Widget>[
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text('Close'),
//                                                       ),
//                                                     ],
//                                                   );
                                                
//                                               },
//                                             );
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     foregroundColor: Color.fromARGB(255, 9, 105, 184), backgroundColor: Colors.white,
//                                                     padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10.0),
//                                                     ),
//                                                     elevation: 5,
//                                                   ),
//                                                   child: Text("Try")))
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ))
//                         ],
//                       );
//   }else if (widget.BMI_Status == "Overweight"){
//     return Row(
//                         children: [
//                           Expanded(
//                               child: SizedBox(
//                             height: 300,
//                             child: ListView.builder(
//                                 itemCount: tutorial.length > 12
//                                         ? tutorial.length - 12
//                                         : 0,
//                                 itemBuilder: (BuildContext context, index) {
//                                    final dataIndex = index + 12;
//                                   return Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(16),
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           color: Color.fromARGB(
//                                               255, 16, 133, 228),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(28))),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("title"),
//                                           Container(
//                                             padding: EdgeInsets.only(top:16),
//                                             alignment: Alignment.bottomRight,
//                                               child: ElevatedButton(
//                                                   onPressed: () {
//                                                     showDialog(
//                                               context: context,
//                                               barrierDismissible: false,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                     title: Text(
//                                                         '${tutorial[dataIndex].title}'),
//                                                     content: Column(
//                                                       children: [
//                                                         Text(
//                                                           '${tutorial[dataIndex].description}',
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         YoutubePlayer(
//                                                           controller:
//                                                               YoutubePlayerController(
//                                                             initialVideoId:
//                                                                 '${tutorial[dataIndex].videoUrl}',
//                                                             flags:
//                                                                 YoutubePlayerFlags(
//                                                                     autoPlay: true,
//                                                                     mute: false),
//                                                           ),
//                                                           showVideoProgressIndicator:
//                                                               true,
//                                                           progressIndicatorColor:
//                                                               Colors.blueAccent,
//                                                         ),
                                                      
//                                                         FloatingActionButton(
//                                                             onPressed: () {
//                                                           setState(() {
//                                                             if (_controller
//                                                                 .value.isPlaying) {
//                                                               _controller.pause();
//                                                             } else {
//                                                               _controller.play();
//                                                             }
//                                                           });
//                                                         }),
//                                                         Icon(_controller
//                                                                 .value.isPlaying
//                                                             ? Icons.pause
//                                                             : Icons.play_arrow)
//                                                       ],
//                                                     ),
//                                                     actions: <Widget>[
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text('Close'),
//                                                       ),
//                                                     ],
//                                                   );
                                                
//                                               },
//                                             );
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     foregroundColor: Color.fromARGB(255, 9, 105, 184), backgroundColor: Colors.white,
//                                                     padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10.0),
//                                                     ),
//                                                     elevation: 5,
//                                                   ),
//                                                   child: Text("Try")))
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ))
//                         ],
//                       );
//   }else {
//     return Row(
//                         children: [
//                           Expanded(
//                               child: SizedBox(
//                             height: 300,
//                             child: ListView.builder(
//                                 itemCount: tutorial.length > 14
//                                         ? tutorial.length - 14
//                                         : 0,
//                                 itemBuilder: (BuildContext context, index) {
//                                    final dataIndex = index + 14;
//                                   return Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(16),
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.rectangle,
//                                           color: Color.fromARGB(
//                                               255, 16, 133, 228),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(28))),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("title"),
//                                           Container(
//                                             padding: EdgeInsets.only(top:16),
//                                             alignment: Alignment.bottomRight,
//                                               child: ElevatedButton(
//                                                   onPressed: () {
//                                                     showDialog(
//                                               context: context,
//                                               barrierDismissible: false,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                     title: Text(
//                                                         '${tutorial[dataIndex].title}'),
//                                                     content: Column(
//                                                       children: [
//                                                         Text(
//                                                           '${tutorial[dataIndex].description}',
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                         YoutubePlayer(
//                                                           controller:
//                                                               YoutubePlayerController(
//                                                             initialVideoId:
//                                                                 '${tutorial[dataIndex].videoUrl}',
//                                                             flags:
//                                                                 YoutubePlayerFlags(
//                                                                     autoPlay: true,
//                                                                     mute: false),
//                                                           ),
//                                                           showVideoProgressIndicator:
//                                                               true,
//                                                           progressIndicatorColor:
//                                                               Colors.blueAccent,
//                                                         ),
                                                      
//                                                         FloatingActionButton(
//                                                             onPressed: () {
//                                                           setState(() {
//                                                             if (_controller
//                                                                 .value.isPlaying) {
//                                                               _controller.pause();
//                                                             } else {
//                                                               _controller.play();
//                                                             }
//                                                           });
//                                                         }),
//                                                         Icon(_controller
//                                                                 .value.isPlaying
//                                                             ? Icons.pause
//                                                             : Icons.play_arrow)
//                                                       ],
//                                                     ),
//                                                     actions: <Widget>[
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text('Close'),
//                                                       ),
//                                                     ],
//                                                   );
                                                
//                                               },
//                                             );
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     foregroundColor: Color.fromARGB(255, 9, 105, 184), backgroundColor: Colors.white,
//                                                     padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10.0),
//                                                     ),
//                                                     elevation: 5,
//                                                   ),
//                                                   child: Text("Try")))
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ))
//                         ],
//                       );
//   }
// }