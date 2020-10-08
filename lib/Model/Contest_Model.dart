class ContestModel {
  final String content;
  final String description;
  final String imageUrl;

  ContestModel({
    this.content,
    this.description,
    this.imageUrl
  });

  Map<String, dynamic> toMap(){

    var data=Map<String,dynamic>();

        data["title"]=content;
        data["description"]=description;
        data["imageUrl"]=imageUrl;
        
        return data;
      }
}
