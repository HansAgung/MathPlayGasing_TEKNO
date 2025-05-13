import 'package:flutter/material.dart';
import '../../features/data/models/materi_model.dart';

class MateriCard extends StatelessWidget {
  final MateriModel materi;

  const MateriCard({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              materi.judulMateri,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              materi.deskripsiMateri,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            const Text("Progress kamu"),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: materi.progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                materi.isLocked ? Colors.grey : Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text("${materi.progress}%"),
          ],
        ),
      ),
    );
  }
}
