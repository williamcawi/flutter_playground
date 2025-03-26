class TaskModel {
  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone});

  final String id;
  final String title;
  final String description;
  final bool isDone;

  TaskModel copyWith(
      {String? id, String? title, String? description, bool? isDone}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
