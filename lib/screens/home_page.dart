import 'package:flutter/material.dart';
import 'package:hackernews/screens/new_stories/new_stories_page.dart';
import 'package:hackernews/screens/settings/settings_page.dart';
import 'package:hackernews/util/no_animation_page_route.dart';

import 'top_stories/top_stories_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _push(_selectedIndex, context);
    });
  }

  void _push(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            NoAnimationPageRoute(
              builder: (context) => HomePage(),
            ));
        break;
      case 1:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => HomePage()));
        break;
      case 2:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => HomePage()));
        break;
      case 3:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => SettingsPage()));
        break;
      default:
        null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color), label: ''),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
