import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/shared/utils/app_colors.dart';

class TermsCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const TermsCheckbox({super.key, required this.onChanged});

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool _isChecked = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: _toggleCheckbox,
            activeColor: Colors.blue,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _toggleCheckbox(!_isChecked),
              child: const Text(
                "Saya menyetujui dan menerima seluruh syarat dan ketentuan yang berlaku",
                style: TextStyle(fontSize: 12, color: AppColors.fontDescColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
