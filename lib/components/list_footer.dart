import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/controllers/list_accounts_controller.dart';
import 'package:kanvalorant/utils/colors.dart';

import '../models/accounts_model.dart';
import 'account_dialog.dart';

class ListFooter extends StatelessWidget {
  ListFooter({
    super.key,
    required this.role,
  });

  final String role;
  final listController = ListAccountsController();
  List<ListAccountsModel> get lAcc => listController.value;

  void openDialog(BuildContext context, String role) {
    showDialog(
      context: context,
      builder: (context) => AccountDialog(
        role: role,
        onSubmit: (model) {
          var la = lAcc.firstWhere((la) => la.role == role);
          la.accounts.add(model);
          listController.board = List.from(lAcc);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Adicionar conta",
              style: GoogleFonts.bowlbyOneSc(
                color: Colors.white,
              ),
            ),
            Tooltip(
              message: "Adicionar conta",
              child: ElevatedButton(
                onPressed: () {
                  openDialog(context, role);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
