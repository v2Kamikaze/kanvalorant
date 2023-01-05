import 'package:flutter/material.dart';

import 'pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Kanvalorant",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
