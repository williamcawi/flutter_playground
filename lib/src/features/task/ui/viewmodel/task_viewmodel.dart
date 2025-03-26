import 'package:flutter/material.dart';
import 'package:flutter_playground/src/features/task/data/model/task_model.dart';
import 'package:flutter_playground/src/features/task/data/repository/task_repository.dart';
import 'package:flutter_playground/src/features/task/ui/viewmodel/task_state.dart';

class TaskViewmodel extends ValueNotifier<TaskState> {
  TaskViewmodel({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial());

  final TaskRepository _taskRepository;

  Future<void> getTasksEvent() async {
    value = TaskLoading();
    final result = await _taskRepository.getTasks();

    result.fold((message) {
      value = TaskError(message: message);
    }, (taskList) {
      value = TaskSuccess(listTasks: taskList);
    });
  }

  Future<void> createTaskEvent({required TaskModel task}) async {
    value = TaskLoading();
    final result = await _taskRepository.createTasks(task: task);

    result.fold((message) {
      value = TaskError(message: message);
    }, (taskList) {
      value = TaskSuccess(listTasks: taskList);
    });
  }

  Future<void> updateTaskEvent({required TaskModel task}) async {
    value = TaskLoading();
    final result = await _taskRepository.updateTasks(task: task);

    result.fold((message) {
      value = TaskError(message: message);
    }, (taskList) {
      value = TaskSuccess(listTasks: taskList);
    });
  }

  Future<void> deleteTaskEvent({required int id}) async {
    value = TaskLoading();
    final result = await _taskRepository.deleteTasks(id: id);

    result.fold((message) {
      value = TaskError(message: message);
    }, (taskList) {
      value = TaskSuccess(listTasks: taskList);
    });
  }
}
