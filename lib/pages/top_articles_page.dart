import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final List<Story> _stories = <Story>[];
  final ScrollController _scrollController = ScrollController();

  int _initialCountOfStories = 20;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _populateTopStories();
    _scrollController.addListener(() {
      var endOfPage = _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels == endOfPage) {
        print('Reached end of page - loading more stories');
        setState(() {
          _isLoading = true;
          _incrementRangeOfStoriesToLoad();
          _fetchNewStories();
          _isLoading = false;
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

  void _fetchNewStories() async {
    final responses = await Util().getTopStories(_initialCountOfStories);
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();

    setState(() {
      _stories.addAll(stories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(milliseconds: 400), () {
          setState(() {
            _populateTopStories();
          });
        });
      },
      child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                StoryCard(
                  key: Key(_stories[index].id.toString()),
                  time: _stories[index].time,
                  url: _stories[index].url,
                  by: _stories[index].by,
                  score: _stories[index].score,
                  title: '(${index.toString()}) - ' + _stories[index].title,
                  comments: _stories[index].commentIds.length,
                ),
                const Divider(),
                if ((index == _stories.length - 1) && _isLoading == true)
                  Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 40,
                  ))
              ],
            );
          }),
    );
  }
}
