import 'package:equatable/equatable.dart';
import 'package:flutter_playground/src/features/task/data/model/task_model.dart';

class TaskState extends Equatable {
  const TaskState([this.taskList]);

  final List<TaskModel>? taskList;

  @override
  List<Object?> get props => [taskList];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  const TaskSuccess({required this.listTasks}) : super(listTasks);

  final List<TaskModel> listTasks;

  @override
  List<Object?> get props => [taskList];
}

class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object?> get props => [message];
}
