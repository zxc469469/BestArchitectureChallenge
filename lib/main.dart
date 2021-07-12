import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'components/PostListView.dart';
import 'components/SortMenuButton.dart';
import 'hooks/useFetch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PostPage(title: 'FlutterTaipei :)'),
    );
  }
}

class PostPage extends HookWidget {
  PostPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final sortCondition =
        useState<SortConditionEnum>(SortConditionEnum.sortWithId);
    final fetchPosts =
        useFetch(Uri.https('jsonplaceholder.typicode.com', '/posts'));
    final _posts = sortPostsData(sortCondition.value, fetchPosts.value);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[SortMenuButton(sortCondition: sortCondition)],
        ),
        body: PostListView(
          postData: _posts,
        ));
  }
}
