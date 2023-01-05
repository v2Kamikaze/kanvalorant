import '../models/accounts_model.dart';

abstract class IDataBase {
  void saveData(List<ListAccountsModel> data);
  Future<List<ListAccountsModel>> readData();
}
