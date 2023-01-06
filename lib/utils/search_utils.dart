import 'package:kanvalorant/models/accounts_model.dart';

bool loginExistsInBoard(String login, List<ListAccountsModel> board) {
  for (var la in board) {
    for (var a in la.accounts) {
      if (a.login == login) {
        return true;
      }
    }
  }
  return false;
}
