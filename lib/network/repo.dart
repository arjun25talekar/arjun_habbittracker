import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/constant.dart';

class Repo {
  /// Fetches quote
  Future<Map<String, dynamic>> fetchRandomQuote() async {
    final url = Uri.parse('$baseUrl/random');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to fetch random quote. Status Code: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuotes(
      {int limit = 10, int skip = 0}) async {
    final url = Uri.parse('$baseUrl?limit=$limit&skip=$skip');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['quotes'] as List)
          .map((quote) => quote as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception(
          'Failed to fetch quotes. Status Code: ${response.statusCode}');
    }
  }
}
