import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';

Task<Either<Exception, List<dynamic>>> fetchData(
  http.Client client,
  Uri postsUri,
) {
  return Task(() async => client.get(postsUri)).map((response) {
    if (response.statusCode == 200) {
      return right(jsonDecode(response.body));
    }
    return left(Exception('error'));
  });
}

ValueNotifier<List> useFetchPostData(Uri uri) {
  final _data = useState([]);
  final _client = http.Client();
  print(_data);

  useEffect(() {
    fetchData(_client, uri)
        .run()
        .then((either) => either.map((data) => _data.value = data))
        .then((error) => throw error);
  }, []);
  print(_data);
  return _data;
}
