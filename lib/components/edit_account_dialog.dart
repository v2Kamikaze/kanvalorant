import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/extensions/elo_enum_extension.dart';

import '../controllers/list_accounts_controller.dart';
import '../enums/elo_enum.dart';
import '../models/account_model.dart';
import '../utils/colors.dart';
import 'custom_edit_text.dart';

class EditAccountDialog extends StatefulWidget {
  const EditAccountDialog(
      {super.key,
      required this.onCreateSubmit,
      required this.account,
      required this.onDeleteSubmit});
  final AccountModel account;
  final void Function(AccountModel) onCreateSubmit;
  final void Function(AccountModel) onDeleteSubmit;

  @override
  State<EditAccountDialog> createState() => _EditAccountDialogState();
}

class _EditAccountDialogState extends State<EditAccountDialog> {
  final TextEditingController _accountLoginController = TextEditingController();

  final TextEditingController _accountLevelController = TextEditingController();

  Elo elo = Elo.unranked;

  final listController = ListAccountsController();

  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<Elo>> createDropDownMenuItems() {
    return Elo.values
        .map(
          (e) => DropdownMenuItem<Elo>(
            value: e,
            alignment: Alignment.center,
            child: Text(
              e.toFormatedString(),
              style: GoogleFonts.bowlbyOneSc(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
        .toList();
  }

  void onEloChanged(Elo? eloSelected) {
    setState(() {
      elo = eloSelected!;
    });
  }

  String? validateLogin(String? login) {
    if (login == null || login.isEmpty) {
      return "O campo não pode ser vazio";
    }

    return null;
  }

  String? validateLevel(String? level) {
    if (level == null || level.isEmpty) {
      return "O campo não pode ser vazio";
    }
    if (int.tryParse(level) == null) {
      return "Digite um valor numérico";
    }
    var levelInt = int.tryParse(level)!;
    return levelInt <= 0 ? "Digite um valor maior que 0" : null;
  }

  void submitEditAccount() {
    if (formKey.currentState!.validate()) {
      var login = _accountLoginController.text.trim();
      var level = int.parse(_accountLevelController.text);
      widget.onCreateSubmit(AccountModel(login, level, elo));
      Navigator.pop(context);
    }
  }

  void submitDeleteAccount() {
    widget.onDeleteSubmit(widget.account);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      elo = widget.account.elo;
      _accountLoginController.text = widget.account.login;
      _accountLevelController.text = widget.account.level.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Editar conta - ${widget.account.login}",
        style: GoogleFonts.bowlbyOneSc(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      icon: const Icon(
        Icons.edit,
        size: 40,
        color: Colors.white,
      ),
      backgroundColor: cardBackgroundColor,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomEditText(
              controller: _accountLoginController,
              hintText: "Login",
              validator: validateLogin,
            ),
            CustomEditText(
              controller: _accountLevelController,
              hintText: "Nível",
              validator: validateLevel,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: DropdownButton<Elo>(
                alignment: Alignment.center,
                dropdownColor: listBackgroundColor,
                value: elo,
                borderRadius: BorderRadius.circular(4),
                items: createDropDownMenuItems(),
                onChanged: onEloChanged,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          onPressed: submitDeleteAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          child: Text(
            "Excluir conta",
            style: GoogleFonts.bowlbyOneSc(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: submitEditAccount,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
          child: Text(
            "Editar",
            style: GoogleFonts.bowlbyOneSc(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
