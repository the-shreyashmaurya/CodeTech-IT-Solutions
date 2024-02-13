import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isDone;

  TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.isDone});
}
