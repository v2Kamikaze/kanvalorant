import 'dart:io';
import 'dart:convert';

import 'package:kanvalorant/db/data_base_interface.dart';
import 'package:path_provider/path_provider.dart';

import '../models/accounts_model.dart';

class FileDB implements IDataBase {
  final String fileName = "accounts.json";
  static final FileDB _fileDB = FileDB._internal();

  factory FileDB() {
    return _fileDB;
  }

  FileDB._internal();

  Future<File> _getFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$fileName");
    if (!(await file.exists())) {
      _writeDefaultValues(file);
      return await file.create();
    }
    return file;
  }

  void _writeDefaultValues(File file) async {
    var defaultValues = {
      "data": [
        {"role": "vitória diária", "accounts": []},
        {"role": "subindo nível", "accounts": []},
        {"role": "subindo elo", "accounts": []},
        {"role": "descendo elo", "accounts": []},
        {"role": "contas prontas", "accounts": []}
      ]
    };

    await file.writeAsString(jsonEncode(defaultValues));
  }

  static void createBackup(List<ListAccountsModel> data, String path) async {
    File file = await File(path).create();
    var jsonData = {"data": []};
    jsonData["data"] = data.map((la) => la.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonData));
  }

  @override
  Future<List<ListAccountsModel>> readData() async {
    File file = await _getFile();
    String strJson = await file.readAsString();
    Map<String, dynamic> json = jsonDecode(strJson);
    var data = json["data"].toList();
    List<ListAccountsModel> listOfListAccounts = [];

    for (Map<String, dynamic> listAccount in data) {
      listOfListAccounts.add(ListAccountsModel.fromJson(listAccount));
    }

    return listOfListAccounts;
  }

  @override
  void saveData(List<ListAccountsModel> data) async {
    var jsonData = {"data": []};
    jsonData["data"] = data.map((la) => la.toJson()).toList();
    File file = await _getFile();
    await file.writeAsString(jsonEncode(jsonData));
  }
}
