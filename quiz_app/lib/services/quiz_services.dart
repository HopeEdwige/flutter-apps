import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/question.dart';

const String baseUrl = 'https://opentdb.com/api.php';
const int total = 10;

Future<List<Question>> getQuizData(Topic topic) async {
  String url = '$baseUrl?amount=$total&category=${topic.id}';

  http.Response res = await http.get(url);
  List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
    json.decode(res.body)['results'],
  );

  return results.map((result) => Question.fromJson(result)).toList();
}
