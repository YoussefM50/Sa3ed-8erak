import 'package:flutter/material.dart';

import '../Theme/theme.dart';

class Mybutton extends StatelessWidget {
  const Mybutton({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Center(
        child: Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryClr
          ),
          child: Center(
            child: Text(
              label,
              style: Titlestyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
