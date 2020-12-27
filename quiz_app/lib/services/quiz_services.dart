import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/quiz_item.dart';

final int minAmount = 3;
final int maxAmount = 10;
final String type = 'multiple';
final String baseUrl = 'https://opentdb.com/api.php';

final random = new Random();

Future<List<QuizItem>> getQuizData(Topic topic) async {
  int amount = minAmount + random.nextInt(maxAmount - minAmount);
  String url = '$baseUrl?amount=$amount&category=${topic.id}&type=$type';

  print('[INFO] Requesting "$amount" questions for "${topic.name}" category');

  http.Response res = await http.get(url);
  List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(
    json.decode(res.body)['results'],
  );

  return results.map((result) => QuizItem.fromJson(result)).toList();
}
