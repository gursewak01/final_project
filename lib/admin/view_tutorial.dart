import 'package:flutter/material.dart';
import '../models/tutorial_model.dart';
import '../recommendations.dart';
import '../widgets/custom_widgets/widgets.dart';

class ViewTutorialPage extends StatefulWidget {
  const ViewTutorialPage({super.key});

  @override
  State<ViewTutorialPage> createState() => _ViewTutorialPageState();
}

class _ViewTutorialPageState extends State<ViewTutorialPage> {
 void refreshData() async{
    try{
      await fetchDataInstance.fetchPosts();
      print('Data refreshed successfully');
    } catch (e){
      print('Failed to refresh data: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Admin"),
        backgroundColor: Colors.purple.shade400,
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () {
          setState(() {
            refreshData();
          });
        }, icon: Icon(Icons.refresh))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<TutorialModel>>(
            future: fetchDataInstance.fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<TutorialModel> tutorial = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                    child: Row(
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
                                    color: Color.fromARGB(255, 16, 133, 228),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(28))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 120,
                                      child: TText("${tutorial[index].title}"),
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 16, left: 10),
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        MText(
                                                        'Title: '),
                                                        MText("${tutorial[index].title.toUpperCase()}"),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        MText(
                                                          'Description: ${tutorial[index].description}',

                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                       MText(
                                                          'Video URL: ${tutorial[index].videoUrl}',

                                                        ),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Close'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Color.fromARGB(
                                                  255, 9, 105, 184),
                                              backgroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 26, vertical: 15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5,
                                            ),
                                            child: Text("View")))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ))
                  ],
                ));
              }
            }),
      ),
    );
  }
}
