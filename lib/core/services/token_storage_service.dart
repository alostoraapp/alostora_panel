import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorageService {
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> deleteAllTokens();
}

class TokenStorageServiceImpl implements TokenStorageService {
  final FlutterSecureStorage _storage;
  const TokenStorageServiceImpl(this._storage);

  // Define keys for storage
  static const String _accessKey = 'alostora_access';
  static const String _refreshKey = 'alostora_refresh';

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshKey);
  }

  @override
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}