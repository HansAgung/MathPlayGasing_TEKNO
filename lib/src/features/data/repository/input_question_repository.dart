import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mathgasing_v1/src/core/helper/global.dart';
import '../models/input_question_model.dart';

class InputTestRepository {  
  Future<InputTestModel> fetchInputTest() async {
    final response = await http.get(Uri.parse('$baseAPI/api/mock/quest/inputTest'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return InputTestModel.fromJson(data['inputTest']);
    } else {
      throw Exception('Failed to load option test');
    }
  }
}
