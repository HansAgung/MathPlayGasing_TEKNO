import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  // Cek apakah email ada di SharedPreferences (sebagai contoh daftar email disimpan dalam list)
  Future<bool> isEmailRegistered(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    return storedEmail == email;
  }

  // Simpan password baru untuk email tertentu
  Future<void> saveNewPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    // Simpan password dengan key unik, misal 'password_<email>'
    await prefs.setString('password_$email', newPassword);
  }

   Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  // Untuk demo, simpan email baru (bisa dipanggil sekali untuk test)
  Future<void> registerEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final emails = prefs.getStringList('registered_emails') ?? [];
    if (!emails.contains(email)) {
      emails.add(email);
      await prefs.setStringList('registered_emails', emails);
    }
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}

