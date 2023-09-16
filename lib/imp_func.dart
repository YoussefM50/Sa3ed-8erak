import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Helper/Share_Pref.dart';

var IsDark=Sharepref.getdata(key: "DarkTheme");
var UID ;
const String kProfilePhoto="https://cdn-icons-png.flaticon.com/512/149/149071.png?w=740&t=st=1681314696~exp=1681315296~hmac=c15c9db7a8516da1d64cb8af78b9dff54227bd328721ddc173e2195877da6b18";
const String kProfilePhoto2="https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1685035604~exp=1685036204~hmac=5a32d0aa0038bd20403b2dba541773daa69c882b9e46ede7ed4bd09bedf3f4b5";
Size mediaquery(context) => MediaQuery.of(context).size;

void go_to(context, screen) => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));

void go_toAnd_finish(context, screen) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) => screen));

IconButton PassIcon(Widget Icon, Function func) => IconButton(
      icon: Icon,
      color: Colors.black,
      onPressed: () => func(),
    );

Future<bool?> showtoast(String txt,int num,{ToastGravity gry=ToastGravity.BOTTOM}) => Fluttertoast.showToast(
    msg: txt,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gry,
    timeInSecForIosWeb: 20,
    backgroundColor:num==1?Colors.green.withOpacity(.7): Colors.red.withOpacity(.7),
    textColor: Colors.white,
    fontSize: 16.0);

