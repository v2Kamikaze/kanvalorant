import "dart:io";

import "package:flutter/material.dart";
import 'package:window_manager/window_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isWindows) {
    WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(400, 600),
    );
    windowManager.waitUntilReadyToShow(windowOptions);
  }

  runApp(const App());
}
