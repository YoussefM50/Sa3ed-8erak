class Post_Model {
  late String postimage1;
  late String postimage2;
  late String postimage3;
  late String postimage4;
  late String description;
  late String category;
  late String userid;
  late String username;
  late String useraddress;
  late String usernumber;
  late int pointsofproduct;
  late int numberofproducts;
  late bool available;
  late String time;
  Post_Model({
    required this.postimage1,
    required this.postimage2,
    required this.postimage3,
    required this.postimage4,
    required this.description,
    required this.category,
    required this.username,
    required this.useraddress,
    required this.usernumber,
    required this.userid,
    required this.available,
    required this.numberofproducts,
    required this.pointsofproduct,
    required this.time
  });

  Post_Model.fromJson(Map<String, dynamic> json) {
    postimage1 = json['postimage1'];
    postimage2 = json['postimage2'];
    postimage3 = json['postimage3'];
    postimage4 = json['postimage4'];
    description = json['description'];
    category = json['category'];
    username = json['username'];
    useraddress = json['useraddress'];
    usernumber = json['usernumber'];
    userid = json['userid'];
    available = json['available'];
    pointsofproduct = json['pointsofproduct'];
    numberofproducts = json['numberofproducts'];
    time = json['time'];

  }

  Map<String, dynamic> ToMap() {
    return {
      'postimage1': postimage1,
      'postimage2': postimage2,
      'postimage3': postimage3,
      'postimage4': postimage4,
      'description': description,
      'category': category,
      'username': username,
      'useraddress': useraddress,
      'usernumber': usernumber,
      'userid': userid,
      'available': available,
      'pointsofproduct': pointsofproduct,
      'numberofproducts': numberofproducts,
      'time': time,

  };
  }
}
