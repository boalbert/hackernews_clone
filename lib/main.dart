import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/screens/new_stories/new_stories_page.dart';
import 'package:hackernews/screens/settings_page/settings_page.dart';
import 'package:hackernews/screens/top_stories/top_stories_page.dart';
import 'package:hackernews/theme/theme_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(toolbarHeight: 15),
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(toolbarHeight: 15),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent))),
        primaryColorDark: Colors.orangeAccent,
      ),
      themeMode: themeMode,
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
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelPadding: EdgeInsets.all(5),
            indicatorWeight: 2,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              Text('Top'),
              Text('New'),
              Text('Show'),
              Text('Ask'),
              Text('Jobs'),
              Text('Settings'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TopStoriesPage(),
            NewStoriesPage(),
            TopStoriesPage(),
            TopStoriesPage(),
            TopStoriesPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
