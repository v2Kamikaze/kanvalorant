import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

import '../components/list_footer.dart';
import '../components/list_header.dart';
import '../models/account_model.dart';
import '../models/accounts_model.dart';

List<DragAndDropList> createList({
  required List<ListAccountsModel> data,
}) {
  return data
      .map(
        (listAccount) => DragAndDropList(
          contentsWhenEmpty: const Center(
            child: Text("Lista vazia."),
          ),
          header: ListHeader(listTitle: listAccount.role),
          footer: ListFooter(role: listAccount.role),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
              )
            ],
          ),
          children: createListItems(listAccount.accounts),
        ),
      )
      .toList();
}

DragHandle createListDragHandle() {
  return const DragHandle(
    verticalAlignment: DragHandleVerticalAlignment.top,
    onLeft: true,
    child: Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Icon(Icons.list),
    ),
  );
}

List<DragAndDropItem> createListItems(List<AccountModel> accounts) {
  return accounts
      .map(
        (account) => DragAndDropItem(
          child: Card(
            child: ListTile(
              title: Text(account.login),
              trailing: const Icon(Icons.list),
            ),
          ),
        ),
      )
      .toList();
}