class ContestModel {
  String content;
  String description;
  String imageUrl;

  ContestModel({this.content, this.description, this.imageUrl});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["title"] = content;
    data["description"] = description;
    data["imageUrl"] = imageUrl;

    return data;
  }

  ContestModel.fromJson(Map<String, dynamic> parsedJson) {
    content = parsedJson['title'];
    description = parsedJson['description'];
    imageUrl = parsedJson['imageUrl'];
  }
}
