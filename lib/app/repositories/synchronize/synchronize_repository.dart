abstract interface class SynchronizeRepository {
  Future<String> login(String url, String email, String password);
}
