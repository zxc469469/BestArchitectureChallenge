import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  PostListView({Key? key, required this.postData});
  final List<dynamic> postData;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: postData.length,
      itemBuilder: (context, index) {
        String id = postData[index]['id'].toString();
        String title = postData[index]['title'].toString();
        String body = postData[index]['body'].toString();
        return Container(
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "$id. $title",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  TextSpan(
                    text: '\n' + body,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
