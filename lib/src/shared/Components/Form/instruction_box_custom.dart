import 'package:flutter/material.dart';

class InstructionBoxCustom extends StatelessWidget {
  final String message; // Parameter teks yang bisa diubah

  const InstructionBoxCustom({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Selebar perangkat
      height: 53, // Tinggi 53px
      padding: const EdgeInsets.symmetric(horizontal: 16), // Padding kiri & kanan
      decoration: BoxDecoration(
        color: const Color(0xFF09B1FF), // Warna background
        borderRadius: BorderRadius.circular(8), // Radius opsional
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline, // Icon alert
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12), // Jarak antara icon dan teks
          Expanded(
            child: Text(
              message, // Teks akan diisi saat komponen dipanggil
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: "Poppins", 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
