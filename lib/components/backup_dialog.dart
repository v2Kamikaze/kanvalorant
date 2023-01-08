import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/utils/colors.dart';

class BackupDialog extends StatelessWidget {
  const BackupDialog({super.key, required this.path});

  final String path;

  void showSnackBar(context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          "Caminho copiado.",
          style: GoogleFonts.bowlbyOneSc(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  Widget childWhenWidth(double width, BuildContext context) {
    var textWidgetSave = Text(
      "O arquivo foi salvo em: ",
      style: GoogleFonts.bowlbyOneSc(
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.normal,
      ),
    );

    var textWidgetPath = SelectableText(
      path,
      style: GoogleFonts.bowlbyOneSc(
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
    );

    var copyButton = Padding(
      padding: width > 1100
          ? const EdgeInsets.only(left: 8.0)
          : const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: listBackgroundColor,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: path)).then((_) {
            showSnackBar(context);
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Copiar",
              style: GoogleFonts.bowlbyOneSc(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.copy_all_outlined),
            ),
          ],
        ),
      ),
    );

    if (width > 1200) {
      return Row(
        children: [
          textWidgetSave,
          textWidgetPath,
          copyButton,
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        textWidgetSave,
        textWidgetPath,
        copyButton,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.backup_rounded,
        size: 40,
        color: Colors.white,
      ),
      title: Text(
        "Backup",
        style: GoogleFonts.bowlbyOneSc(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: backgroundColor,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: Text(
            "OK",
            style: GoogleFonts.bowlbyOneSc(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
      content: childWhenWidth(screenWidth(context), context),
    );
  }
}
