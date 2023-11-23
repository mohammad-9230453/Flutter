import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name = "";
  @HiveField(1)
  bool isCompleted = false;
  @HiveField(2)
  Priority priority = Priority.normal;
  @HiveField(3, defaultValue: 0)
  double id = 0;
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  high
}
