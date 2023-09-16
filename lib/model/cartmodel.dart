class Cart_Model {
  late String postimage1;
  late String description;
  late String category;
  late String postid;
  late int pointsofproduct;
  late int numberofproducts;
  int? mynumProduct;
  late bool available;
  late String username;
  late String useraddress;
  late String usernumber;

  Cart_Model({
    required this.postimage1,
    required this.description,
    required this.category,
    required this.postid,
    required this.available,
    this.mynumProduct,
    required this.numberofproducts,
    required this.pointsofproduct,
    required this.username,
    required this.useraddress,
    required this.usernumber,
  });

  Cart_Model.fromJson(Map<String, dynamic> json) {
    postimage1 = json['postimage1'];
    description = json['description'];
    category = json['category'];
    postid = json['postid'];
    available = json['available'];
    pointsofproduct = json['pointsofproduct'];
    mynumProduct = json['mynumProduct'];
    numberofproducts = json['numberofproducts'];
    username = json['username'];
    useraddress = json['useraddress'];
    usernumber = json['usernumber'];
  }

  Map<String, dynamic> ToMap() {
    return {
      'postimage1': postimage1,
      'description': description,
      'category': category,
      'postid': postid,
      'available': available,
      'pointsofproduct': pointsofproduct,
      'mynumProduct': mynumProduct,
      'numberofproducts': numberofproducts,
      'username': username,
      'useraddress': useraddress,
      'usernumber': usernumber,
    };
  }
}
