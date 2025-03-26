import 'package:flutter_playground/src/features/task/data/model/task_model.dart';
import 'package:flutter_playground/src/features/task/data/service/task_service.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TaskRepository {
  Future<Either<String, List<TaskModel>>> getTasks();
  Future<Either<String, List<TaskModel>>> createTasks(
      {required TaskModel task});
  Future<Either<String, List<TaskModel>>> updateTasks(
      {required TaskModel task});
  Future<Either<String, List<TaskModel>>> deleteTasks({required String id});
}

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({required TaskService taskService})
      : _taskService = taskService;

  final TaskService _taskService;

  @override
  Future<Either<String, List<TaskModel>>> createTasks(
      {required TaskModel task}) async {
    try {
      return Right(await _taskService.createTask(task: task));
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> deleteTasks({required String id}) async {
    try {
      return Right(await _taskService.deleteTask(id: id));
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      return Right(await _taskService.getTasks());
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> updateTasks(
      {required TaskModel task}) async {
    try {
      return Right(await _taskService.updateTask(task: task));
    } catch (error) {
      return Left(error.toString());
    }
  }
}
