import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/helper/global.dart';
import '../models/flashcard_model.dart';

class FlashcardRepository {
  Future<FlashcardModel> fetchFlashcardTest() async {
    final response = await http.get(Uri.parse('$baseAPI/api/mock/quest/flashCard'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return FlashcardModel.fromJson(data['flashcard_item']);
    } else {
      throw Exception('Failed to load option test');
    }
  }
}
