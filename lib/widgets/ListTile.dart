import 'package:flutter/material.dart';

class MYLISTtile extends StatelessWidget {
  const MYLISTtile(
      {super.key,
      required this.label,
      required this.sublabel,
      required this.ontap});
  final String label;
  final String sublabel;

  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: Text(sublabel),
      // trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: ontap(),
    );
  }
}
