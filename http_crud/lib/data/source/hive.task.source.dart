import 'package:hive/hive.dart';
import 'package:http_crud/data.dart';
import 'package:http_crud/data/source/source.dart';

class HiveDataSource implements DataSource<Task> {
  final Box<Task> box;

  HiveDataSource({required this.box});
  @override
  Future<Task> createOrUpdate(Task data) async {
    if (data.isInBox) {
      data.save();
    } else {
      await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(Task data) {
    return data.delete();
  }

  @override
  Future<void> deleteAll({String searchKeyword = ""}) {
    if (searchKeyword.isEmpty) {
      return box.clear();
    } else {
      return Future<void>(() => box.values
              .where((task) =>
                  task.name.toLowerCase().contains(searchKeyword.toLowerCase()))
              .toList()
              .forEach((task) {
            task.delete();
          }));
    }
  }

  @override
  Future<void> deleteById(id) {
    return box.values.where((element) => element.id == id).first.delete();
  }

  @override
  Future<Task> findById(id) async {
    return await box.values.where((element) => element.id == id).first;
  }

  @override
  Future<List<Task>> getAll({String searchKeyword = ""}) async {
    if (searchKeyword.isEmpty) {
      return box.values.toList();
    } else {
      return box.values
          .where((task) =>
              task.name.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }
  }

  @override
  Future<bool> hsValue() {
    return Future(() => box.isNotEmpty);
  }
}
