import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/screens/home_page.dart';
import 'package:hackernews/screens/search/search_page.dart';
import 'package:hackernews/theme/theme_provider.dart';
import 'package:hackernews/util/no_animation_page_route.dart';
import 'package:hackernews/widgets/shared/padded_scaffold.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _Settings2State();
}

class _Settings2State extends ConsumerState<SettingsPage> {
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
        // Navigator.push(context, NoAnimationPageRoute(builder: (context) => HomePage()));
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, NoAnimationPageRoute(builder: (context) => SearchPage()));
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  void toggleThemeMode(bool value, WidgetRef ref) {
    if (value) {
      ref.read(themeModeProvider.state).state = ThemeMode.dark;
    } else {
      ref.read(themeModeProvider.state).state = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return PaddedScaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        toolbarHeight: 64,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),

          // Divider(),
          Row(
            children: [
              Text('Dark Mode'),
              Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleThemeMode(value, ref);
                },
              )
            ],
          ),
          Text(
            'About',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('Developer'),
              Spacer(),
              Text('andersson.albert@gmail.com'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('Version'),
              Spacer(),
              Text('0.1'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text('Repo'),
              Spacer(),
              Expanded(
                child: Text(
                  'github.com/boalbert/hackernews_clone',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color), label: 'More'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
