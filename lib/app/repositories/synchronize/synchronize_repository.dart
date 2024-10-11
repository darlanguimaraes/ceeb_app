abstract interface class SynchronizeRepository {
  Future<String> login(String email, String password);
}
