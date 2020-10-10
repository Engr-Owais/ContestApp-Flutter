class UserContestModel {
  String username;
  String email;
  String id;
  String imageUrlUser;
  String phone;
  int votes;
  bool isWinner;

  UserContestModel({this.username, this.email, this.imageUrlUser , this.phone , this.votes,this.id ,this.isWinner});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["username"] =username;
    data["email"] = email;
    data["id"] =id;
    data["imageUrlUser"] = imageUrlUser;
    data["phone"] = phone;
    data["votes"] = votes;
    data["isWinner"] = isWinner;

    return data;
  }

  UserContestModel.fromJson(Map<String, dynamic> parsedJson) {
    username = parsedJson['username'];
    email = parsedJson['email'];
    id = parsedJson['id'];
    imageUrlUser = parsedJson['imageUrlUser'];
    phone = parsedJson['phone'];
    votes = parsedJson['votes'];
  }
}
