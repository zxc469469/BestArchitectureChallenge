import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SortConditionEnum {
  sortWithId,
  sortWithTitle,
  sortWithTitleLength,
  sortWithBodyLength
}

final sortConditProvider = StateProvider((ref) => SortConditionEnum.sortWithId);
// final sortedPostListProvider = Provider<List<dynamic>>((ref) {
//   final sorter = ref.watch(sortConditProvider);
//   final posts = ref.watch(postNotifierProvider.notifier).state;

//   switch (sorter.state) {
//     case SortConditionEnum.sortWithId:
//       return sortPostsData(sorter.state,posts.state);
//     case SortConditionEnum.sortWithBodyLength:
//       return posts;
//     case SortConditionEnum.sortWithTitle:
//       return posts;
//     case SortConditionEnum.sortWithTitleLength:
//       return posts;
//   }
// });

class SortMenuButton extends HookWidget {
  const SortMenuButton({
    Key? key,
    required this.sortCondition,
  }) : super(key: key);

  final ValueNotifier<SortConditionEnum> sortCondition;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('使用id排序'),
                value: SortConditionEnum.sortWithId,
              ),
              PopupMenuItem(
                child: Text('使用title排序'),
                value: SortConditionEnum.sortWithTitle,
              ),
              PopupMenuItem(
                child: Text('使用title長度排序'),
                value: SortConditionEnum.sortWithTitleLength,
              ),
              PopupMenuItem(
                child: Text('使用body長度排序'),
                value: SortConditionEnum.sortWithBodyLength,
              )
            ],
        onSelected: (SortConditionEnum value) {
          sortCondition.value = value;
          context.read(sortConditProvider).state = value;
        });
  }
}

List sortPostsData(SortConditionEnum sortConditionEnum, data) {
  final _data = []..addAll(data);
  if (sortConditionEnum == SortConditionEnum.sortWithId) {
    _data.sort((a, b) {
      return int.parse(a['id'].toString())
          .compareTo(int.parse(b['id'].toString()));
    });
  } else if (sortConditionEnum == SortConditionEnum.sortWithTitle) {
    _data.sort((a, b) {
      return a['title'].toString().compareTo(b['title'].toString());
    });
  } else if (sortConditionEnum == SortConditionEnum.sortWithTitleLength) {
    _data.sort((a, b) {
      return a['title']
          .toString()
          .length
          .compareTo(b['title'].toString().length);
    });
  } else if (sortConditionEnum == SortConditionEnum.sortWithBodyLength) {
    _data.sort((a, b) {
      return a['body'].toString().length.compareTo(b['body'].toString().length);
    });
  }
  return _data;
}
