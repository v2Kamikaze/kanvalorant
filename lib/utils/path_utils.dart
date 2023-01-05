import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<String> backupPath() async {
  var dir = await getApplicationDocumentsDirectory();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy_MM_dd_hh_mm_ss');
  var date = formatter.format(now);
  var path = "${dir.path}\\backup_$date.json";
  return path;
}
