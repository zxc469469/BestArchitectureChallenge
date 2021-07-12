import 'package:best_architecture_challenge/components/SortMenuButton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client, http.Request, http.Response])
void main() {
  group('sortPostsData', () {
    final testData = [
      {"id": 1, "body": 'zfqwe qe kqwe lqwe', "title": 'dqwes1'},
      {"id": 2, "body": 'aboeqwelqwe', "title": 'aqweqwel'},
      {"id": 3, "body": '1weqp123', "title": 'bdfwe'},
    ];
    test('sortWithId', () {
      expect(sortPostsData(SortConditionEnum.sortWithId, testData), testData);
    });
    test('sortWithBodyLength', () {
      expect(sortPostsData(SortConditionEnum.sortWithBodyLength, testData), [
        {"id": 3, "body": '1weqp123', "title": 'bdfwe'},
        {"id": 2, "body": 'aboeqwelqwe', "title": 'aqweqwel'},
        {"id": 1, "body": 'zfqwe qe kqwe lqwe', "title": 'dqwes1'},
      ]);
    });
    test('sortWithTitle', () {
      expect(
        sortPostsData(SortConditionEnum.sortWithTitle, testData),
        [
          {'id': 2, 'body': 'aboeqwelqwe', 'title': 'aqweqwel'},
          {'id': 3, 'body': '1weqp123', 'title': 'bdfwe'},
          {'id': 1, 'body': 'zfqwe qe kqwe lqwe', 'title': 'dqwes1'}
        ],
      );
    });
    test('sortWithTitleLength', () {
      expect(
        sortPostsData(SortConditionEnum.sortWithTitleLength, testData),
        [
          {'id': 3, 'body': '1weqp123', 'title': 'bdfwe'},
          {'id': 1, 'body': 'zfqwe qe kqwe lqwe', 'title': 'dqwes1'},
          {'id': 2, 'body': 'aboeqwelqwe', 'title': 'aqweqwel'},
        ],
      );
    });
  });
}
