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
  List<Story> _stories = <Story>[];

  final ScrollController _scrollController = new ScrollController();

  int topStories = 50;

  @override
  void initState() {
    super.initState();
    _populateTopStories();

    _scrollController.addListener(() {
      var endOfPage = _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels ==
          endOfPage) {
        print('End of page!');
        setState(() {
          increaseTopStories();
          _populateTopStories();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void increaseTopStories() {
    topStories = topStories + 50;
    print(topStories);
  }

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

    // Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => CommentPage(story: story, comments: comments);
    // ));
  }

  void _populateTopStories() async {
    final responses = await Util().getTopStories(topStories);
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
        return Future.delayed(Duration(milliseconds: 200), () {
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
                  title: _stories[index].title,
                  comments: _stories[index].commentIds.length,
                ),
                const Divider(),
              ],
            );
          }),
    );
  }
}
