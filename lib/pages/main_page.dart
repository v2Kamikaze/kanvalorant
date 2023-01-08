import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanvalorant/components/background_decoration.dart';

import 'package:kanvalorant/components/backup_dialog.dart';
import 'package:kanvalorant/controllers/list_accounts_controller.dart';
import 'package:kanvalorant/db/file_db.dart';
import 'package:kanvalorant/utils/colors.dart';

import '../models/accounts_model.dart';
import '../utils/drag_list_utils.dart';
import '../utils/path_utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _listController = ListAccountsController();
  final _scrollController = ScrollController();

  List<ListAccountsModel> get lAcc => _listController.value;

  void onItemReorder(
    int oldItemIdx,
    int oldListIdx,
    int newItemIdx,
    int newListIdx,
  ) {
    if (newListIdx == oldListIdx) {
      final item = lAcc[oldListIdx].accounts.removeAt(oldItemIdx);
      lAcc[newListIdx].accounts.insert(newItemIdx, item);
      _listController.board = List.from(lAcc);
      return;
    }

    final item = lAcc[oldListIdx].accounts.removeAt(oldItemIdx);
    if (lAcc[newListIdx].accounts.isEmpty) {
      lAcc[newListIdx].accounts.add(item);
      _listController.board = List.from(lAcc);
      return;
    }

    lAcc[newListIdx].accounts.insert(newItemIdx, item);

    _listController.board = List.from(lAcc);
  }

  void onListReorder(int oldListIdx, int newListIdx) {
    final draggedList = lAcc.removeAt(oldListIdx);
    lAcc.insert(newListIdx, draggedList);
    _listController.board = List.from(lAcc);
  }

  void onBackupButtonPressed() async {
    var path = await backupPath();
    FileDB.createBackup(lAcc, path);
    showDialog(
      context: context,
      builder: (_) => BackupDialog(
        path: path,
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gerenciador de contas",
          style: GoogleFonts.bowlbyOneSc(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onBackupButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Gerar arquivo de backup",
                style: GoogleFonts.bowlbyOneSc(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const BackgroundDecoration(),
          Center(
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 10,
              trackColor: Colors.black,
              thumbColor: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: SizedBox(
                  width: 1500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: ValueListenableBuilder(
                      builder: (BuildContext context, value, _) {
                        return lAcc.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : DragAndDropLists(
                                lastItemTargetHeight: 50,
                                axis: Axis.horizontal,
                                listWidth: 300,
                                listDraggingWidth: 300,
                                listDragOnLongPress: false,
                                itemDragOnLongPress: false,
                                itemSizeAnimationDurationMilliseconds: 50,
                                listSizeAnimationDurationMilliseconds: 200,
                                listPadding: const EdgeInsets.all(10),
                                listDragHandle: createListDragHandle(),
                                children: createList(data: value),
                                onItemReorder: onItemReorder,
                                onListReorder: onListReorder,
                                itemGhost: createItemGhost(),
                              );
                      },
                      valueListenable: _listController,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
