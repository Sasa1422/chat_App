
class userModel {
    final   String uid;
    final   String name;
    final   String email;
    final  String imageURL;
  late  DateTime lastActive;



  userModel({
    required  this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.lastActive

  });
 factory userModel.fromJSON(Map<String,dynamic> jeson){
    return userModel(
        uid:jeson["uid"],
        email:jeson["email"],
        imageURL:jeson["image"],
        lastActive:jeson["lastAction"].toDate(),
         name: jeson['name'],
        );


  }
  Map<String,dynamic> toMap(){
    return {
      "email":email,
      "name":name,
      "lastActive":lastActive,
      "imageURL":imageURL
    };
  }
  String LastDayActive(){
    return '${lastActive.day}/${lastActive.month}/${lastActive.year}';
  }
  bool wasRecentlyActive(){
    return DateTime.now().difference(lastActive).inHours<2;
  }

}

