import 'package:flutter/material.dart';
import 'package:flutter_playground/src/features/task/ui/view/task_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(),
    );
  }
}
