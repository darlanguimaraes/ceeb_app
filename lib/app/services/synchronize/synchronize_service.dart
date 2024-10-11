abstract interface class SynchronizeService {
  Future<void> synchronize(String email, String password);
}
