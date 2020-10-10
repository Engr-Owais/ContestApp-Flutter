class ContestModel {
  String content;
  String description;
  String imageUrl;
  int startDate;
  int status;

  ContestModel(
      {this.content,
      this.description,
      this.imageUrl,
      this.startDate,
      this.status});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["title"] = content;
    data["description"] = description;
    data["imageUrl"] = imageUrl;
    data["startDate"] = startDate;
    data["status"] = status;

    return data;
  }

  ContestModel.fromJson(Map<String, dynamic> parsedJson) {
    content = parsedJson['title'];
    description = parsedJson['description'];
    imageUrl = parsedJson['imageUrl'];
    startDate = parsedJson['startDate'];
    status = parsedJson['status'];
  }
}
