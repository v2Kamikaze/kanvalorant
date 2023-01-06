import "package:flutter/material.dart";
import 'package:kanvalorant/components/custom_edit_text.dart';
import 'package:kanvalorant/controllers/list_accounts_controller.dart';
import 'package:kanvalorant/extensions/elo_enum_extension.dart';
import 'package:kanvalorant/models/account_model.dart';

import '../enums/elo_enum.dart';
import '../utils/search_utils.dart';

class AccountDialog extends StatefulWidget {
  const AccountDialog({super.key, required this.role, required this.onSubmit});
  final String role;
  final void Function(AccountModel) onSubmit;

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  final TextEditingController _accountLoginController = TextEditingController();
  final TextEditingController _accountLevelController = TextEditingController();
  Elo elo = Elo.unranked;

  final listController = ListAccountsController();

  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<Elo>> createDropDownMenuItems() {
    return Elo.values
        .map((e) =>
            DropdownMenuItem<Elo>(value: e, child: Text(e.toFormatedString())))
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

    if (loginExistsInBoard(login, listController.board)) {
      return "Já existe uma conta com o login \"$login\"";
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

  void submitNewAccount() {
    if (formKey.currentState!.validate()) {
      var login = _accountLoginController.text.trim();
      var level = int.parse(_accountLevelController.text);
      widget.onSubmit(AccountModel(login, level, elo));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar conta"),
      icon: const Icon(Icons.add_box),
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
            DropdownButton<Elo>(
              value: elo,
              borderRadius: BorderRadius.circular(4),
              items: createDropDownMenuItems(),
              onChanged: onEloChanged,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: submitNewAccount,
          child: const Text("Criar"),
        ),
      ],
    );
  }
}
