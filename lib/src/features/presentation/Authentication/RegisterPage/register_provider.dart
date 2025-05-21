import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/character_repository.dart';

class RegisterProvider extends ChangeNotifier {
  String? _gender;
  String? _selectedCharacter;
  List<CharacterModel> _characters = [];

  // ✅ Getter
  String? get gender => _gender;
  String? get selectedCharacter => _selectedCharacter;
  List<CharacterModel> get characters => _characters;

  // ✅ Fungsi untuk mengambil karakter dari JSON
  Future<void> loadCharacters() async {
    final repository = CharacterRepository();
    _characters = await repository.fetchCharacters();
    notifyListeners();
  }

  // ✅ Fungsi untuk mengatur gender & menyimpannya ke SharedPreferences
  Future<void> setGender(String selectedGender) async {
    _gender = selectedGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', selectedGender);
    notifyListeners();

    print("✅ Gender tersimpan: $selectedGender");
  }

  // ✅ Fungsi untuk memilih karakter & menyimpannya ke SharedPreferences
  Future<void> setCharacter(String character) async {
    _selectedCharacter = character;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('character', character);
    notifyListeners();

    print("✅ Karakter tersimpan: $character");
  }

  // ✅ Simpan semua data user ke SharedPreferences setelah proses registrasi
  Future<void> setUserData({
    required String fullName,
    required String username,
    required String email,
    required DateTime birthDate,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('birthDate', birthDate.toIso8601String());
    await prefs.setString('password', password);
    await prefs.setInt('points', 100); 
    await prefs.setInt('energy', 100); 
    await prefs.setString('status_subscribe', 'none');
    notifyListeners();

    print("✅ Data pengguna berhasil disimpan:");
    print("Full Name: ${prefs.getString('fullName')}");
    print("Username: ${prefs.getString('username')}");
    print("Email: ${prefs.getString('email')}");
    print("Birth Date: ${prefs.getString('birthDate')}");
    print("Password: ${prefs.getString('password')}");
    print("Birth Date: ${prefs.getString('birthDate')}");
    print("Poin: ${prefs.getInt('points')}");
    print("Energy: ${prefs.getInt('energy')}");
    print("status_subscribe: ${prefs.getString('status_subscribe')}");
    print("character: ${prefs.getString('character')}");
  }
}
