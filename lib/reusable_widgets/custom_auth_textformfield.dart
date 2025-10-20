import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthTextFormField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    bool obscure = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(color: Colors.black38),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(width: 1.5, color: Colors.black54),
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(6),
                ),
                suffixIcon: isPassword
                    ? IconButton(
                  onPressed: () =>
                      setState(() => obscure = !obscure),
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
