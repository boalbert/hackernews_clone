import 'package:flutter/material.dart';
import 'package:hackernews/pages/top_articles_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
          dividerTheme: DividerThemeData(space: 10, indent: 20, endIndent: 20)),
      home: const MyHomePage(title: 'Stories'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56, // defaults to 56
        title: Text(
          widget.title,
        ),
      ),
      body: TopArticleList(),
    );
  }
}
