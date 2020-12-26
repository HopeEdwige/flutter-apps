import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/question.dart';

final String baseUrl = 'https://opentdb.com/api.php';

final int total = 10;
final String type = 'multiple';

Future<List<Question>> getQuizData(Topic topic) async {
  String url = '$baseUrl?amount=$total&category=${topic.id}&type=$type';

  http.Response res = await http.get(url);
  List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
    json.decode(res.body)['results'],
  );

  return results.map((result) => Question.fromJson(result)).toList();
}
