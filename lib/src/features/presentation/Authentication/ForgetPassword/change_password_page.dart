import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Authentication/login_page.dart';
import 'package:mathgasing_v1/src/shared/Components/Button/button_primary_custom.dart';
import 'package:mathgasing_v1/src/shared/Components/Form/custom_password_field.dart';
import 'package:mathgasing_v1/src/shared/Components/Form/term_checkbox.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';
import '../../../data/repository/user_database_repository.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final UserRepository _userRepository = UserRepository();

  bool _termsChecked = false;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _submit() async {
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });

    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password tidak boleh kosong";
      });
      return;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        _confirmPasswordError = "Konfirmasi password tidak boleh kosong";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = "Password tidak cocok";
      });
      return;
    }

    if (!_termsChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap setujui syarat dan ketentuan')),
      );
      return;
    }

    // Simpan password baru melalui repository
    await _userRepository.savePassword(password);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diubah')),
    );

    _goToLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/img_forgetpassword_page.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.58,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const Text(
                    "Buat Ulang Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins-Bold',
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Jangan lupa lagi ya!!",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins-Medium',
                      color: AppColors.thirdColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomPasswordField(
                    hintText: 'Masukan Password baru',
                    controller: passwordController,
                    
                  ),
                  const SizedBox(height: 15),
                  CustomPasswordField(
                    hintText: 'Konfirmasi Password baru',
                    controller: confirmPasswordController,
                   
                  ),
                  const Spacer(),
                  TermsCheckbox(
                    onChanged: (isChecked) {
                      setState(() {
                        _termsChecked = isChecked ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ButtonPrimaryCustom(
                    text: 'Ubah Password',
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
