import 'package:flutter/material.dart';

class PaddedScaffold extends StatefulWidget {
  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;

  const PaddedScaffold({Key? key, this.appBar, this.body, this.bottomNavigationBar}) : super(key: key);

  @override
  State<PaddedScaffold> createState() => _PaddedScaffoldState();
}

class _PaddedScaffoldState extends State<PaddedScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: widget.body,
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
