import 'package:flutter/material.dart';

class NumberOfResults extends StatelessWidget {
  final int numberOfHits;
  final int processingTimeMS;

  const NumberOfResults(this.numberOfHits, this.processingTimeMS, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$numberOfHits results (${(processingTimeMS / 1000)} seconds)',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
