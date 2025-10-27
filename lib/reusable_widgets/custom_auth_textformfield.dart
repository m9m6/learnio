import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '${widget.hintText} is required';
    }

    //pasword check
    if (widget.isPassword) {
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Password must contain at least one lowercase letter';
      }
      if (!RegExp(r'\d{2,}').hasMatch(value)) {
        return 'Password must contain at least two numbers';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters ';
      }
    } else if (widget.hintText.toLowerCase().contains('gmail')) {
      //email check
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email ... example@email.com';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 357,
          height: 64,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            validator: _validator,
            decoration: InputDecoration(
              fillColor: AppColors.firstOnBoardingColor,
              filled: true,
              hintText: widget.hintText,
              hintStyle: AppStyles.blue35W600.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black26,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xff1F41BB),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 29),
      ],
    );
  }
}
