import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/story_card.dart';
import 'package:hackernews/network/util.dart';

import 'model/story.dart';

class TopArticleList extends StatefulWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  List<Story> _stories = <Story>[];

  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {
    final responses = await Util().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();

    setState(() {
      _stories = stories;
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
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                StoryCard(
                  time: _stories[index].time,
                  url: _stories[index].url,
                  by: _stories[index].by,
                  score: _stories[index].score,
                  title: _stories[index].title,
                  comments: _stories[index].commentIds.length,
                ),
                Divider(),
              ],
            );
          }),
    );
  }
}
