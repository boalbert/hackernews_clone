import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/screens/new_stories/new_stories_page.dart';
import 'package:hackernews/screens/top_stories/top_stories_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // R 237 G 112 B 45
        // 246 246 240
        appBarTheme: AppBarTheme(toolbarHeight: 15),
        primarySwatch: Colors.orange,
      ),
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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelPadding: EdgeInsets.all(5),
            indicatorWeight: 2,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              Text('Top'),
              Text('New'),
              Text('Show'),
              Text('Ask'),
              Text('Jobs'),
            ],
          ),
        ),
        body: const TabBarView(children: [
          TopStoriesPage(),
          NewStoriesPage(),
          TopStoriesPage(),
          TopStoriesPage(),
          TopStoriesPage(),
        ]),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       widget.title,
    //     ),
    //   ),
    //   body: TopArticleList(),
    // );
  }
}
