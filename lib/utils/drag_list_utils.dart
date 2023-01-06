import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/components/list_item.dart';
import 'package:kanvalorant/utils/colors.dart';

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
          contentsWhenEmpty: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Lista vazia.",
                style: GoogleFonts.bowlbyOneSc(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          header: ListHeader(listTitle: listAccount.role),
          footer: ListFooter(role: listAccount.role),
          decoration: BoxDecoration(
            color: listBackgroundColor,
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
      child: Icon(
        Icons.list,
        color: Colors.white,
      ),
    ),
  );
}

Container createItemGhost() {
  return Container(
    height: 65,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cardBackgroundColor,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: primaryColor,
        style: BorderStyle.solid,
      ),
    ),
  );
}

List<DragAndDropItem> createListItems(List<AccountModel> accounts) {
  return accounts
      .map(
        (account) => DragAndDropItem(
          child: ListItem(account: account),
        ),
      )
      .toList();
}
