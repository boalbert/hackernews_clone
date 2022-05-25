import 'package:flutter/material.dart';

class EmptySearchResult extends StatelessWidget {
  final String text;

  const EmptySearchResult(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
    );
  }
}
