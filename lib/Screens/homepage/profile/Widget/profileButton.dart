
  import 'package:flutter/material.dart';

buttoncontainer(String str) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(child: Text(str)),
    );
  }