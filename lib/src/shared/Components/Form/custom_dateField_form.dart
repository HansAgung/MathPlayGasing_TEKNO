import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mathgasing_v1/src/shared/Utils/app_colors.dart';

class CustomDateFieldForm extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final String? errorMessage;

  const CustomDateFieldForm({
    super.key,
    required this.onDateSelected,
    this.errorMessage,
  });

  @override
  _CustomDateFieldFormState createState() => _CustomDateFieldFormState();
}

class _CustomDateFieldFormState extends State<CustomDateFieldForm> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    bool isError = widget.errorMessage != null && widget.errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
              widget.onDateSelected(pickedDate);
            }
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isError ? const Color(0xFFFF0000) : const Color(0xFFE6C887),
                width: isError ? 2 : 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? "Pilih Tanggal"
                      : DateFormat("dd MMM yyyy").format(selectedDate!),
                  style: TextStyle(
                    fontSize: 16,
                    color: isError ? const Color(0xFFFF0000) : AppColors.primaryColor,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFE6C887),
                ),
              ],
            ),
          ),
        ),

        // 🔹 Jika ada error message, tampilkan di bawahnya
        if (isError)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 4),
            child: Text(
              widget.errorMessage!,
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
