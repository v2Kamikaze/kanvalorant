import 'package:flutter/material.dart';
import 'package:kanvalorant/db/data_base_interface.dart';
import 'package:kanvalorant/db/file_db.dart';
import 'package:kanvalorant/models/accounts_model.dart';

class ListAccountsController extends ValueNotifier<List<ListAccountsModel>> {
  final IDataBase _db = FileDB();

  static final ListAccountsController _controller =
      ListAccountsController._internal();

  factory ListAccountsController() {
    return _controller;
  }

  ListAccountsController._internal() : super([]) {
    _db.readData().then((data) => value = data);
  }

  List<ListAccountsModel> get board => value;

  set board(List<ListAccountsModel> newValue) {
    value = newValue;
    _db.saveData(value);
  }
}
