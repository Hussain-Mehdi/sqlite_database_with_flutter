abstract class IRepository<T>{

  Future<void> add<T>(T object); 
  Future<void> update<T>(T object);
  Future<T> get<T>(int id); 
  Future<List<T>> getAll<T>();
  Future<String> delete<T>(int id);

}