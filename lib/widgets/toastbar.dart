import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void mytoastbar({required String text, required BuildContext context}) {
  var mediaquery = MediaQuery.of(context).size;
  showToastWidget(
    SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: mediaquery.width / 30,
              vertical: mediaquery.width / 50),
          margin: EdgeInsets.symmetric(horizontal: mediaquery.width / 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            color: Colors.red.withOpacity(.7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    context: context,
    isIgnoring: false,
    duration: const Duration(seconds: 4),
  );
}
