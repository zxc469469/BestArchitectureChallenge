import 'dart:convert';

import 'package:best_architecture_challenge/hooks/useFetch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'useFetch_test.mocks.dart';

@GenerateMocks([http.Client, http.Request, http.Response])
void main() {
  group('fetchData', () {
    final MockClient client = MockClient();

    test('returns a posts if the http call completes successfully', () async {
      final postsUri = Uri.https('jsonplaceholder.typicode.com', '/posts');
      when(client.get(postsUri)).thenAnswer((_) async => http.Response(
          '[{"usetId":1,"id": 1, "title": "test", "body": "mock"}]', 200));

      expect(
          await fetchData(client, postsUri),
          jsonDecode(
              '[{"usetId":1,"id": 1, "title": "test", "body": "mock"}]'));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final postsUri = Uri.https('jsonplaceholder.typicode.com', '/posts');
      when(
        client.get(postsUri),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchData(client, postsUri), throwsException);
    });
  });
}
