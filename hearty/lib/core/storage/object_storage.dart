abstract class ObjectStorage {
  Future<bool> contains(String key);

  Future<T> get<T>(String key);
  Future<void> remove(String key);

  Future<void> put(String key, Object object);

  Future<void> clear();

  Future<Iterable<String>> getKeys();
}
