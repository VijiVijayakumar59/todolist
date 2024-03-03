import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? note;
  TodoModel({
    this.note,
    this.title,
  });
}
