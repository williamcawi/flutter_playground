import 'package:flutter/material.dart';
import 'package:flutter_playground/src/features/task/data/model/task_model.dart';
import 'package:flutter_playground/src/features/task/ui/viewmodel/task_state.dart';
import 'package:flutter_playground/src/features/task/ui/viewmodel/task_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskViewmodel taskViewmodel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() async {
    super.initState();
    taskViewmodel = context.read<TaskViewmodel>();
    await taskViewmodel.getTasksEvent();

    taskViewmodel.addListener(
      () {
        final state = taskViewmodel.value;

        if (state is TaskError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error:'),
              content: Text(state.message),
              actions: [
                ElevatedButton(
                    onPressed: Navigator.of(context).pop, child: Text('Ok'))
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    taskViewmodel.removeListener(() {});
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskViewmodel,
          builder: (_, state, __) {
            if (state is TaskLoading) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: state.taskList?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                      value: state.taskList?[index].isDone ?? false,
                      onChanged: (value) async {
                        await taskViewmodel.updateTaskEvent(
                            task:
                                state.taskList![index].copyWith(isDone: value));
                      }),
                  title: Text(state.taskList?[index].title ?? ''),
                  subtitle: Text(state.taskList?[index].description ?? ''),
                  trailing: IconButton(
                      onPressed: () {
                        if (state.taskList?[index].id != null) {
                          taskViewmodel.deleteTaskEvent(
                              id: state.taskList![index].id);
                        }
                      },
                      icon: Icon(Icons.delete)),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  TextFormField(),
                  TextFormField(),
                  ElevatedButton(
                      onPressed: () {
                        taskViewmodel.createTaskEvent(
                            task: TaskModel(
                                id: Uuid().v1(),
                                title: titleController.text,
                                description: descriptionController.text,
                                isDone: false));
                      },
                      child: Text('Create task'))
                ],
              );
            },
          );
        },
        child: Text('New Task'),
      ),
    );
  }
}
