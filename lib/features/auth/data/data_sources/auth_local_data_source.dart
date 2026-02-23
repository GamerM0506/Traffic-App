import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({required String access, required String refresh});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveTokens({required String access, required String refresh}) async{
    await storage.write(key: 'ACCESS_TOKEN', value: access);
    await storage.write(key: 'REFRESH_TOKEN', value: refresh);
  }

  @override
  Future<String?> getAccessToken() async => await storage.read(key: 'ACCESS_TOKEN');

  @override
  Future<String?> getRefreshToken() async => await storage.read(key: 'REFRESH_TOKEN');

  @override
  Future<void> clearAll() async => await storage.deleteAll();
}