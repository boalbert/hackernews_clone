import 'package:flutter/material.dart';
import 'package:hackernews/screens/home_page.dart';
import 'package:hackernews/screens/search/search_page.dart';
import 'package:hackernews/screens/settings/settings_page.dart';
import 'package:hackernews/util/no_animation_page_route.dart';
import 'package:hackernews/widgets/shared/padded_scaffold.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _push(index, context);
    });
  }

  void _push(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => SearchPage()));
        break;
      case 2:
        break;
      case 3:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => SettingsPage()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaddedScaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
        ),
        toolbarHeight: 64,
      ),
      body: Center(
        child: Text('Bookmarks'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Theme.of(context).iconTheme.color), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_rounded, color: Theme.of(context).iconTheme.color), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, color: Theme.of(context).iconTheme.color), label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
