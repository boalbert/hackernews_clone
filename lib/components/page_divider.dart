import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageDivider extends StatelessWidget {
  final int pageNumber;

  const PageDivider({
    Key? key,
    required this.pageNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: double.infinity, height: 30.0),
      child: Container(
        color: Colors.grey,
        height: 30,
        child: Center(
          child: Text('Page $pageNumber'),
        ),
      ),
    );
  }
}
