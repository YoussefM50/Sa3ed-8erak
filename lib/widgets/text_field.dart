import 'package:final_pro/Helper/Share_Pref.dart';
import 'package:flutter/material.dart';
import '../Theme/theme.dart';

Widget TEXTFIELD(
    TextEditingController varname,
    var kbt, //keyboard type
    String label, //label
    String hint, //hint
    Widget icon, //icon
    bool ot, //text visible
    {TextEditingController? conpass}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'برجاء ادخال $label';
        } else if (value.length != 14 && label == "الرقم القومي") {
          print("Errrrrrrrrrrrrrrrrrrrrrror");
          return 'غير صالحه ';
        } else if (value != conpass?.text && conpass != null) {
          return 'غير متطابق';
        }
        return null;
      },
      cursorColor:
          Sharepref.getdata(key: "DarkTheme") ? Colors.white : Colors.black26,
      obscureText: ot,
      controller: varname,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: .5, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: .5, color: Colors.black54),
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
        labelStyle: Sharepref.getdata(key: "DarkTheme")
            ? Titlestyle
            : Titlestyle.copyWith(color: Colors.black),
        hintText: hint,
        hintStyle: Sharepref.getdata(key: "DarkTheme")
            ? Body2lestyle.copyWith(color: Colors.white)
            : Body2lestyle,
        suffixIcon: icon,
        suffixIconColor: primaryClr,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 1,
            )),
      ),
      keyboardType: kbt,
    ),
  );
}
