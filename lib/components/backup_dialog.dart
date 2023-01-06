import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackupDialog extends StatelessWidget {
  const BackupDialog({super.key, required this.path});

  final String path;

  void showSnackBar(context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Caminho copiado."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.backup_rounded),
      title: const Text("Backup"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        )
      ],
      content: Row(
        children: [
          SelectableText("O arquivo foi salvo em: $path"),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
              child: const Icon(Icons.copy_all_outlined),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: path)).then((_) {
                  showSnackBar(context);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
