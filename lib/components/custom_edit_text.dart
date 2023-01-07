import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/utils/colors.dart';

class CustomEditText extends StatelessWidget {
  const CustomEditText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.bowlbyOneSc(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        errorStyle: GoogleFonts.bowlbyOneSc(
          color: primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      cursorColor: primaryColor,
      validator: validator,
      style: GoogleFonts.bowlbyOneSc(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
