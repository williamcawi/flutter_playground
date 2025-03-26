import 'package:flutter_playground/src/features/task/data/model/task_model.dart';

abstract interface class TaskService {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> createTask({required TaskModel task});
  Future<List<TaskModel>> updateTask({required TaskModel task});
  Future<List<TaskModel>> deleteTask({required String id});
}

class TaskServiceImpl implements TaskService {
  List<TaskModel> taskList = [];

  @override
  Future<List<TaskModel>> createTask({required TaskModel task}) async {
    taskList.add(task);
    return Future.value(taskList);
  }

  @override
  Future<List<TaskModel>> deleteTask({required String id}) async {
    taskList.removeWhere((task) => task.id == id);
    return Future.value(taskList);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return Future.value(taskList);
  }

  @override
  Future<List<TaskModel>> updateTask({required TaskModel task}) {
    final index = taskList.indexWhere(
      (t) => t.id == task.id,
    );
    if (index != -1) {
      taskList[index] = task;
    }

    return Future.value(taskList);
  }
}
