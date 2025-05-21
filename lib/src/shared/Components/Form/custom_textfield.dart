import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorMessage; // Pesan error yang bisa diatur dari luar

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    bool isError = errorMessage != null && errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: isError ? const Color(0xFFFF0000) : const Color(0xFFE6C887),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isError ? const Color(0xFFFF0000) : const Color(0xFFE6C887),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isError ? const Color(0xFFFF0000) : const Color(0xFFE6C887),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isError ? const Color(0xFFFF0000) : const Color(0xFFE6C887),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: const TextStyle(color: Colors.black),
        ),

        // Jika ada errorMessage, maka tampilkan teks error
        if (isError)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 4),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Color(0xFFFF2D2D),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
