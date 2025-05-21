import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomPasswordField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;
  String? _errorMessage;

  void _validatePassword() {
    String password = widget.controller.text;
    if (password.length < 8) {
      setState(() {
        _errorMessage = "Password harus lebih dari 8 karakter";
      });
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      setState(() {
        _errorMessage = "Password harus ada setidaknya 1 huruf kapital";
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          onChanged: (value) => _validatePassword(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Color(0xFFE6C887)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE6C887)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE6C887)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE6C887), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFFE6C887),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            errorText: _errorMessage,
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}