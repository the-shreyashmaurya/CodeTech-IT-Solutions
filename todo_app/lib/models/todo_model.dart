import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String dueDate;



  TodoModel(
      {required this.title, required this.description, required this.dueDate});
}
