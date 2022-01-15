import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/page_divider.dart';
import 'package:hackernews/components/story_card.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';

class TopArticleList extends StatefulWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  late Future<List<Story>> _futureStories;
  final ScrollController _scrollController = ScrollController();

  int currentPage = 0;
  int _initialCountOfStories = 20;

  @override
  void initState() {
    super.initState();
    _futureStories = _loadStories();

    _scrollController.addListener(() {
      var endOfPage = _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels == endOfPage) {
        print('Reached end of page - loading more stories');
        setState(() {
          _incrementRangeOfStoriesToLoad();
          // _fetchNewStories().then((value) => _futureStories.);
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

  Future<List<Story>> _loadStories() async {
    print('_loadStories called');
    final responses = await Util().getTopStories(20);

    return responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();
  }

  // ignore: unused_element
  Future<List<Story>> _loadNewStories() async {
    final responses = await Util().getTopStories(_initialCountOfStories);
    return responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();
  }

  bool _togglePageDivider(int index) {
    return ((index + 1) % 20 == 0) && index != 0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureStories,
      builder: (context, AsyncSnapshot story) {
        if (!story.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              controller: _scrollController,
              itemCount: story.data.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    StoryCard(
                      key: Key(story.data[index].time.toString()),
                      time: story.data[index].time,
                      url: story.data[index].url,
                      by: story.data[index].by,
                      score: story.data[index].score,
                      title:
                          '(${index.toString()}) - ' + story.data[index].title,
                      comments: 0,
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
    );
  }
}
