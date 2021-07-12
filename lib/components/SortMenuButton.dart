import 'package:flutter/material.dart';

enum SortConditionEnum {
  sortWithId,
  sortWithTitle,
  sortWithTitleLength,
  sortWithBodyLength
}

class SortMenuButton extends StatelessWidget {
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
