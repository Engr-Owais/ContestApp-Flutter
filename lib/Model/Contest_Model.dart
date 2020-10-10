class ContestModel {
  String content;
  String description;
  String imageUrl;
  int endDate;
  String id;

  int status;

  ContestModel(
      {this.content,
      this.description,
      this.imageUrl,
      this.endDate,
      this.status,
      this.id
      });

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["title"] = content;
    data["description"] = description;
    data["imageUrl"] = imageUrl;
    data["endDate"] = endDate;
    data["status"] = status;
    data["id"] = id;


    return data;
  }

  ContestModel.fromJson(Map<String, dynamic> parsedJson) {
    content = parsedJson['title'];
    description = parsedJson['description'];
    imageUrl = parsedJson['imageUrl'];
    endDate = parsedJson['endDate'];
    status = parsedJson['status'];
    id = parsedJson['id'];
  }
}
