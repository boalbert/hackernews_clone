import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: double.infinity, height: 30.0),
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text('Page NewPage',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
      ),
    );
  }
}
