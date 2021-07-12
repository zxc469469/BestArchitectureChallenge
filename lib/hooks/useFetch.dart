import 'dart:convert';
import 'package:best_architecture_challenge/modal/posts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

Task<Either<Exception, http.Response>> fetchData(
  http.Client client,
  Uri postsUri,
) {
  return Task(() async => client.get(postsUri)).map((response) {
    if (response.statusCode == 200) {
      return right(response);
    }
    return left(Exception('error'));
  });
}

ValueNotifier<List> useFetch(Uri uri) {
  final _data = useState([]);
  final _client = http.Client();
  useEffect(() {
    fetchData(_client, uri)
        .run()
        .then((either) => either.map((data) {
              _data.value = jsonDecode(data.body);
            }))
        .then((error) => throw error);
  }, []);
  return _data;
}
