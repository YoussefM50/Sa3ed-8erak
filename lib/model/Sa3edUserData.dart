class Social_model {
  late String Fname, Lname, email, Uid,address,id,phonenumber;
  late int point;
  Social_model(
      {required this.Fname,
      required this.Lname,
      required this.email,
      required this.Uid,
      required this.address,
      required this.id,
      required this.phonenumber,
      this.point=30
});

  Social_model.fromJson(Map<String, dynamic> Json) {
    Fname = Json['Fname'];
    Lname = Json['Lname'];
    email = Json['email'];
    Uid = Json['Uid'];
    address = Json['address'];
    id = Json['id'];
    phonenumber = Json['phonenumber'];
    point=Json['point'];
  }

  Map<String, dynamic> tomap() {
    return {
      'Fname': Fname,
      'Lname': Lname,
      'email': email,
      'Uid': Uid,
      'address': address,
      'id': id,
      'phonenumber': phonenumber,
      'point':point
    };
  }
}
