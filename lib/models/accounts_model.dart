import 'package:kanvalorant/models/account_model.dart';

class ListAccountsModel {
  String role = "";
  List<AccountModel> accounts = [];

  ListAccountsModel(this.role, this.accounts);

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data["role"] = role;
    data["accounts"] = accounts.map((acc) => acc.toJson()).toList();
    return data;
  }

  ListAccountsModel.fromJson(Map<String, dynamic> json) {
    role = json["role"];
    for (Map<String, dynamic> account in json["accounts"]) {
      accounts.add(AccountModel.fromJson(account));
    }
  }
}
