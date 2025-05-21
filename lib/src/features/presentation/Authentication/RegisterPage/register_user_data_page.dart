import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_primary_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_fourth_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Form/custom_dateField_form.dart';
import 'package:mathgasing_v1/src/shared/Components/Form/custom_password_field.dart';
import 'package:mathgasing_v1/src/shared/Components/Form/custom_textfield.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'register_provider.dart';
import 'register_character_page.dart';

class RegisterUserDataPage extends StatefulWidget {
  const RegisterUserDataPage({super.key});

  @override
  _RegisterUserDataPageState createState() => _RegisterUserDataPageState();
}

class _RegisterUserDataPageState extends State<RegisterUserDataPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  DateTime? selectedDate;
  bool isTextFilled = false; // 🔹 Untuk memeriksa validasi form

  @override
  void initState() {
    super.initState();
    
    // 🔹 Tambahkan listener untuk setiap text field agar bisa mengecek validasi form secara otomatis
    fullNameController.addListener(_validateForm);
    usernameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // 🔹 Hapus listener ketika widget tidak lagi digunakan
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // 🔹 Cek validasi form setiap kali ada perubahan pada field
  void _validateForm() {
    setState(() {
      isTextFilled = _isFormValid();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Gambar Latar Belakang
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/asset_register.png',
              width: double.infinity,
              height: screenHeight * 0.3,
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Tombol Back di Pojok Kiri Atas Gambar
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // 🔹 Container Putih untuk Form Registrasi
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.76,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // 🔹 Drag Indicator
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 102,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Judul di Atas Form
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Buat Akun Baru",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Masukkan data kamu dengan benar!",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins-Medium',
                          color: AppColors.thirdColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // 🔹 Form yang Bisa di-Scroll
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(hintText: 'Masukan Nama Lengkap', controller: fullNameController),
                          SizedBox(height: 35),
                          CustomTextField(hintText: 'Masukan Nama Pengguna', controller: usernameController),
                          SizedBox(height: 35),
                          CustomTextField(hintText: 'Masukan Email Anda', controller: emailController),
                          SizedBox(height: 35),
                          CustomDateFieldForm(
                            onDateSelected: (DateTime? date) {
                              setState(() {
                                selectedDate = date;
                                _validateForm(); // 🔹 Validasi form setelah memilih tanggal
                              });
                            },
                          ),
                          SizedBox(height: 35),
                          CustomPasswordField(hintText: 'Masukan Password Anda', controller: passwordController),
                          SizedBox(height: 35),
                          CustomPasswordField(hintText: 'Masukan Ulang Password Anda', controller: confirmPasswordController),
                          SizedBox(height: 35),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Tombol "Lanjut" yang Memiliki Logika Validasi
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: isTextFilled
                          ? ButtonPrimaryCustom(
                              text: "Selanjutnya",
                              onPressed: _validateAndSubmit,
                            )
                          : ButtonFourthCustom(
                              text: "Selanjutnya",
                              onPressed: null,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Validasi Form
  bool _isFormValid() {
    return fullNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        selectedDate != null &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  // 🔹 Fungsi untuk Pindah ke Halaman Selanjutnya
  void _validateAndSubmit() {
    final provider = Provider.of<RegisterProvider>(context, listen: false);

    if (_isFormValid()) {
      provider.setUserData(
        fullName: fullNameController.text,
        username: usernameController.text,
        email: emailController.text,
        birthDate: selectedDate!,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterCharacterPage()),
      );
    }
  }
}
