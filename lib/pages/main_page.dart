import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:intl/intl.dart';

import 'package:kanvalorant/components/backup_dialog.dart';
import 'package:kanvalorant/controllers/list_accounts_controller.dart';
import 'package:kanvalorant/db/file_db.dart';
import 'package:path_provider/path_provider.dart';

import '../models/accounts_model.dart';
import '../utils/drag_list_utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final listController = ListAccountsController();

  List<ListAccountsModel> get lAcc => listController.value;

  void onItemReorder(
    int oldItemIdx,
    int oldListIdx,
    int newItemIdx,
    int newListIdx,
  ) {
    if (newListIdx == oldListIdx) {
      final item = lAcc[oldListIdx].accounts.removeAt(oldItemIdx);
      lAcc[newListIdx].accounts.insert(newItemIdx, item);
      listController.board = List.from(lAcc);
      return;
    }

    final item = lAcc[oldListIdx].accounts.removeAt(oldItemIdx);
    if (lAcc[newListIdx].accounts.isEmpty) {
      lAcc[newListIdx].accounts.add(item);
      listController.board = List.from(lAcc);
      return;
    }

    lAcc[newListIdx].accounts.insert(newItemIdx, item);

    listController.board = List.from(lAcc);
  }

  void onListReorder(int oldListIdx, int newListIdx) {
    final draggedList = lAcc.removeAt(oldListIdx);
    lAcc.insert(newListIdx, draggedList);
    listController.board = List.from(lAcc);
  }

  double calcListSize(BuildContext context) {
    final size = MediaQuery.of(context).size.width * (1.0 / lAcc.length) - 20;
    return size > 250 ? size : 250;
  }

  Future<String> backupPath() async {
    var dir = await getApplicationDocumentsDirectory();
    var now = DateTime.now();
    var formatter = DateFormat('yyyy_MM_dd_hh_mm_ss');
    var date = formatter.format(now);
    var path = "${dir.path}\\backup_$date.json";
    return path;
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciador de contas"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  var path = await backupPath();
                  FileDB.createBackup(lAcc, path);
                  showDialog(
                    context: context,
                    builder: (_) => BackupDialog(
                      path: path,
                    ),
                  );
                },
                child: const Text("Gerar backup"),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder(
          builder: (BuildContext context, value, Widget? child) {
            return lAcc.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DragAndDropLists(
                    axis: Axis.horizontal,
                    listWidth: calcListSize(context),
                    listDraggingWidth: calcListSize(context),
                    listDragOnLongPress: false,
                    itemDragOnLongPress: false,
                    itemSizeAnimationDurationMilliseconds: 50,
                    listSizeAnimationDurationMilliseconds: 200,
                    listPadding: const EdgeInsets.all(8.0),
                    listDragHandle: createListDragHandle(),
                    children: createList(data: lAcc),
                    onItemReorder: onItemReorder,
                    onListReorder: onListReorder,
                  );
          },
          valueListenable: listController,
        ));
  }
}
