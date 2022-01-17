import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comments = FetchData().getComments(widget.story);
  }

  //                 return Container(child: Text(snapshot.data![index].text));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: FutureBuilder<List<Comment>>(
        future: _comments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      child: Text(snapshot.data![index].commentId.toString() +
                          snapshot.data![index].text),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Snapshot has error'),
            );
          } else {
            print(snapshot);
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
