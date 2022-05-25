import 'package:flutter/material.dart';

class SmallCardText extends StatelessWidget {
  const SmallCardText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
