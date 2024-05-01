import 'package:dio/dio.dart';

import 'tutorial_model.dart';

class AllTutorials {
  Dio dio = Dio();

  Future<List<TutorialModel>> getTutorials() async {
    Response response = await dio.get("http://localhost:3001/tutorial/all-tutorial");
    List<dynamic> data = response.data;
    print("API Response: $data");
    return data.map((e) => TutorialModel.fromJson(e)).toList();
  }
}