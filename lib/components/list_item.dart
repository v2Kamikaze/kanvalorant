import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/components/edit_account_dialog.dart';
import 'package:kanvalorant/db/file_db.dart';
import 'package:kanvalorant/extensions/elo_enum_extension.dart';
import 'package:kanvalorant/utils/colors.dart';
import 'package:kanvalorant/utils/elo_images.dart';
import 'package:transparent_image/transparent_image.dart';

import '../controllers/list_accounts_controller.dart';
import '../enums/elo_enum.dart';
import '../models/account_model.dart';
import '../models/accounts_model.dart';

class ListItem extends StatelessWidget {
  ListItem({super.key, required this.account});

  final AccountModel account;

  final listController = ListAccountsController();
  List<ListAccountsModel> get lAcc => listController.value;

  String imageSrcFromElo() {
    switch (account.elo) {
      case Elo.unranked:
        return unrankedSrc;
      case Elo.iron:
        return ironSrc;
      case Elo.bronze:
        return bronzeSrc;
      case Elo.silver:
        return silverSrc;
      case Elo.gold:
        return goldSrc;
      case Elo.platinum:
        return platinumSrc;
      case Elo.diamond:
        return diamondSrc;
      case Elo.immortal:
        return immortalSrc;
      case Elo.ascendant:
        return ascendantSrc;
      case Elo.radiant:
        return radiantSrc;
    }
  }

  void onDeleteSubmit(AccountModel model) {
    for (var la in listController.board) {
      for (var acc in la.accounts) {
        if (acc.login == model.login) {
          la.accounts.remove(acc);
          break;
        }
      }
    }
    listController.board = List.from(lAcc);
    FileDB().saveData(listController.board);
  }

  void onCreateSubmit(AccountModel model) {
    account.login = model.login;
    account.level = model.level;
    account.elo = model.elo;
    listController.board = List.from(lAcc);
    FileDB().saveData(listController.board);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditAccountDialog(
        account: account,
        onDeleteSubmit: onDeleteSubmit,
        onCreateSubmit: onCreateSubmit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: primaryColor,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        textColor: Colors.white,
        leading: Tooltip(
          message: account.elo.toFormatedString(),
          child: FadeInImage.memoryNetwork(
            width: 40,
            height: 40,
            placeholder: kTransparentImage,
            image: imageSrcFromElo(),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Login: ${account.login}",
          style: GoogleFonts.bowlbyOneSc(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          "Nível: ${account.level}",
          style: GoogleFonts.bowlbyOneSc(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          tooltip: "Editar conta",
          onPressed: () {
            openDialog(context);
          },
        ),
      ),
    );
  }
}
