import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/page_divider.dart';
import 'package:hackernews/components/story_card.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopArticleList extends StatefulWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  final ScrollController _scrollController = ScrollController();

  final PagingController<int, Story> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await FetchData().loadStories(pageKey);
      final nextPageKey = pageKey += 20;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  bool _togglePageDivider(int index) {
    return ((index + 1) % 20 == 0) && index != 0;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Story>(
          itemBuilder: (context, item, index) => Column(
            children: [
              StoryCard(
                  title: item.title,
                  score: item.score,
                  by: item.by,
                  url: item.url,
                  comments: item.commentIds.length,
                  time: item.time),
              Visibility(
                  visible: _togglePageDivider(index), child: PageDivider())
            ],
          ),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _pagingController.dispose();
  }
}
