class Order_Model {
  late String postimage1;
  late String description;
  late int numberofproducts;
  late bool available;
  late String time;
  late String donorname;
  late String donoraddress;
  late String donornumber;
  late String inneedname;
  late String inneedaddress;
  late String inneednumber;

  Order_Model(
      {required this.postimage1,
      required this.description,
      required this.available,
      required this.numberofproducts,
        required this.time,
      required this.donorname,
      required this.donoraddress,
      required this.donornumber,
      required this.inneedname,
      required this.inneedaddress,
      required this.inneednumber});

  Order_Model.fromJson(Map<String, dynamic> json) {
    postimage1 = json['postimage1'];
    description = json['description'];
    available = json['available'];
    time = json['time'];
    numberofproducts = json['numberofproducts'];
    donorname = json['donorname'];
    donoraddress = json['donoraddress'];
    donornumber = json['donornumber'];
    inneedname = json['inneedname'];
    inneedaddress = json['inneedaddress'];
    inneednumber = json['inneednumber'];
  }

  Map<String, dynamic> ToMap() {
    return {
      'postimage1': postimage1,
      'description': description,
      'available': available,
      'time': time,
      'numberofproducts': numberofproducts,
      'donorname': donorname,
      'donoraddress': donoraddress,
      'donornumber': donornumber,
      'inneedname': inneedname,
      'inneedaddress': inneedaddress,
      'inneednumber': inneednumber,
    };
  }
}
