import 'package:http_crud/data/source/source.dart';

class Repository<T> implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository({required this.localDataSource});

  @override
  Future<T> createOrUpdate(T data) {
    return localDataSource.createOrUpdate(data);
  }

  @override
  Future<void> delete(T data) {
    return localDataSource.delete(data);
  }

  @override
  Future<void> deleteAll({String searchKeyword = ""}) {
    return localDataSource.deleteAll(searchKeyword: searchKeyword);
  }

  @override
  Future<void> deleteById(id) {
    return localDataSource.deleteById(id);
  }

  @override
  Future<T> findById(id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ""}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }

  @override
  Future<bool> hsValue() {
    return localDataSource.hsValue();
  }
}
