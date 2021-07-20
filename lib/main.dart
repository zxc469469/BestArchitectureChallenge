import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/PostListView.dart';
import 'components/SortMenuButton.dart';
import 'hooks/useFetch.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final StateNotifierProvider<PostState, List<dynamic>> postNotifierProvider =
    StateNotifierProvider<PostState, List<dynamic>>((ref) => PostState());

class PostState extends StateNotifier<List<dynamic>> {
  PostState() : super([]);

  void load(post) => state = post;
  void changeSort(SortConditionEnum sortConditionEnum) {
    // print(state);
    state = sortPostsData(sortConditionEnum, state);
    // print(state);
  }

  @override
  String toString() {
    return 'state：$state';
  }
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

    useProvider(postNotifierProvider.notifier).load(fetchPosts.value);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[SortMenuButton(sortCondition: sortCondition)],
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final number = watch(postNotifierProvider.notifier);
            final sort = watch(sortConditProvider);
            print(sort.state);
            return Text(number.toString());
          },
        )
        //  PostListView(
        //   postData: _posts,
        // ),
        );
  }
}
