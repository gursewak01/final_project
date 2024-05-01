import 'package:flutter/material.dart';

import 'models/tutorial_model.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({super.key, required this.tutorialData});
  final List<TutorialModel> tutorialData;

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("${widget.tutorialData[1].title}"),
      ),
      body: ListView.builder(
        itemCount: widget.tutorialData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${widget.tutorialData[index].title}"),
          );
        },
      ),
    );
  }
}