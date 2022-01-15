import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/page_divider.dart';
import 'package:hackernews/components/story_card.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';

class TopArticleList extends StatefulWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  List<Story> _stories = <Story>[];
  final ScrollController _scrollController = ScrollController();
  bool loading = true;

  int currentPage = 0;
  int _initialCountOfStories = 20;

  @override
  void initState() {
    super.initState();
    // _populateTopStories();
    _scrollController.addListener(() {
      var endOfPage = _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels == endOfPage) {
        print('Reached end of page - loading more stories');
        setState(() {
          _incrementRangeOfStoriesToLoad();
          _fetchNewStories().then((value) => _stories.addAll(value));
          currentPage++;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _incrementRangeOfStoriesToLoad() {
    _initialCountOfStories = _initialCountOfStories + 20;
  }

  // ignore: unused_element
  _navigateToShowCommentsPage(BuildContext context, int index) async {
    // Hämta story för index
    final story = _stories[index];
    // Hämta kommentarer för story
    final responses = await Util().getCommentsByStoryId(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJson(json);
    }).toList();

    debugPrint("$comments");
  }

  void _populateTopStories() async {
    final responses = await Util().getTopStories(20);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();

    setState(() {
      _stories.clear();
      _stories.addAll(stories);
    });
  }

  _loadStories() async {
    print('_loadStories called');
    final responses = await Util().getTopStories(20);

    return responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();
  }

  _fetchNewStories() async {
    final responses = await Util().getTopStories(_initialCountOfStories);
    return responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();

    // setState(() {
    //   _stories.addAll(stories);
    // });
  }

  //FutureBuilder(
  //   future: _fetchListItems(),
  //   builder: (context, AsyncSnapshot snapshot) {
  //     if (!snapshot.hasData) {
  //       return Center(child: CircularProgressIndicator());
  //     } else {
  //       Container(
  //           child: ListView.builder(
  //               itemCount: snapshot.data.length,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Text('${snapshot.data[index].title}');
  //               }));
  //     }
  //   });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(milliseconds: 400), () {
          // setState(() {
          //   _populateTopStories();
          // });
        });
      },
      child: FutureBuilder(
        future: _loadStories(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            _stories = snapshot.data as List<Story>;
            return ListView.builder(
                controller: _scrollController,
                itemCount: _stories.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      StoryCard(
                        key: Key(_stories[index].time.toString()),
                        time: _stories[index].time,
                        url: _stories[index].url,
                        by: _stories[index].by,
                        score: _stories[index].score,
                        title:
                            '(${index.toString()}) - ' + _stories[index].title,
                        comments: _stories[index].commentIds.length,
                      ),
                      const Divider(),
                      Visibility(
                        visible: _togglePageDivider(index),
                        child: PageDivider(
                          key: Key(index.toString()),
                          pageNumber: currentPage,
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  bool _togglePageDivider(int index) {
    return ((index + 1) % 20 == 0) && index != 0;
  }
}
