import 'package:flutter/material.dart';
import 'package:flutter_playground/src/features/task/data/repository/task_repository.dart';
import 'package:flutter_playground/src/features/task/data/service/task_service.dart';
import 'package:flutter_playground/src/features/task/ui/view/task_view.dart';
import 'package:flutter_playground/src/features/task/ui/viewmodel/task_viewmodel.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => TaskServiceImpl(),
        ),
        Provider(
          create: (context) => TaskRepositoryImpl(taskService: context.read()),
        ),
        Provider(
          create: (context) => TaskViewmodel(taskRepository: context.read()),
        )
      ],
      child: TaskView(),
    );
  }
}
