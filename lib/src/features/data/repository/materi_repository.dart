import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/materi_model.dart';

class MateriRepository {
  Future<List<MateriModel>> fetchMateri() async {
    final String response =
        await rootBundle.loadString('lib/src/features/data/datasources/data_materi.json');
    final data = json.decode(response) as List;
    return data.map((e) => MateriModel.fromJson(e)).toList();
  }
}
