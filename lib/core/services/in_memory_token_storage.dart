import 'token_storage_service.dart';

// An in-memory implementation of TokenStorageService for web compatibility.
// Note: This is not persistent across page reloads.
class InMemoryTokenStorage implements TokenStorageService {
  final Map<String, String> _store = {};

  static const String _accessKey = 'alostora_access';
  static const String _refreshKey = 'alostora_refresh';

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _store[_accessKey] = accessToken;
    _store[_refreshKey] = refreshToken;
  }

  @override
  Future<String?> getAccessToken() async {
    return _store[_accessKey];
  }

  @override
  Future<String?> getRefreshToken() async {
    return _store[_refreshKey];
  }

  @override
  Future<void> deleteAllTokens() async {
    _store.clear();
  }
}
