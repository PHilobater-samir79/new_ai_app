import 'dart:convert';

import 'package:http/http.dart' as http;

class DicApiManger {
  Future<Map<String, dynamic>> getDicData({required String text}) async {
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$text';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
