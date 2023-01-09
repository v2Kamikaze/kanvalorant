import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/utils/colors.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color:
            role == "vitória diária" ? const Color(0xFF185B61) : primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              role.toUpperCase(),
              style: GoogleFonts.bowlbyOneSc(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
