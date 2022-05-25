import 'package:flutter/material.dart';

class SmallCardText extends StatelessWidget {
  const SmallCardText({
    required this.text,
    required this.fontWeight,
  });

  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: fontWeight, fontSize: 11),
    );
  }
}
