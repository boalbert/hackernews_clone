import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/providers/search_provider.dart';
import 'package:hackernews/screens/home_page.dart';
import 'package:hackernews/screens/settings/settings_page.dart';
import 'package:hackernews/util/no_animation_page_route.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/story/story_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _selectedIndex = 1;

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
    var result = ref.watch(searchStoryByRelevanceProvider(_controller.text));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
        ),
        toolbarHeight: 64,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Colors.grey.withOpacity(0.15),
                hintText: '',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _controller.clear,
                      )
                    : null,
              ),
              autofocus: true,
              onSubmitted: (value) {
                setState(() {
                  _controller.text = value;
                });
              },
            ),
          ),
          result.when(
              data: (data) {
                if (data.searchHits!.isEmpty) {
                  return EmptySearchResult('No results');
                }
                if (_controller.text.isEmpty) {
                  return EmptySearchResult('No results');
                }
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StoryCard(
                        key: Key('${data.searchHits![index].createdAt.toString()} - ${data.searchHits![index].storyId}'),
                        url: data.searchHits![index].url ?? 'url null',
                        title: data.searchHits![index].storyTitle ?? data.searchHits![index].title!,
                        by: data.searchHits![index].author!,
                        time: data.searchHits![index].createdAt!,
                        score: data.searchHits![index].points.toString() == 'null' ? '0' : data.searchHits![index].points.toString(),
                        comments: data.searchHits![index].numberOfComments ?? 0,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: data.searchHits!.length,
                  ),
                );
              },
              error: (e, st) => ErrorMessage(e.toString()),
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  )),
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

class EmptySearchResult extends StatelessWidget {
  final String text;

  const EmptySearchResult(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 30,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
      ),
    );
  }
}
