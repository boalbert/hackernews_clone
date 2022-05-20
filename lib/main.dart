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

class Index extends StateNotifier<int> {
  Index() : super(0);

  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

class _MyHomePageState extends State<MyHomePage> {
  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final List<Widget> fragments = const [Text('Page 1'), Text('Page 2'), Text('Page 3')];

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
        bottomNavigationBar: BottomNavigationBar(items: navItems),
      ),
    );
  }
}
