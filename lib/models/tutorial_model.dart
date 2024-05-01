class TutorialModel{
  String title;
  String description;
  String videoUrl;
  TutorialModel({required this.title,required this.description, required this.videoUrl});

  factory TutorialModel.fromJson(Map<String, dynamic> json){
    return TutorialModel(title: json['title'], description: json['description'], videoUrl: json['videoUrl']);
  }

  Map<String, dynamic> toJson() {
    return {"title":title, "description":description, "videoUrl":videoUrl};
  }
}