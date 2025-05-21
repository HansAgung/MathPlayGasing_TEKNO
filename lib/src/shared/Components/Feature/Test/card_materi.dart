import 'package:flutter/material.dart';

class CardMateri extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final int progress;
  final bool isLocked;

  const CardMateri({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.progress,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              deskripsi,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Progress kamu',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.orange,
              minHeight: 10,
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 4),
            Text(
              '$progress%',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
