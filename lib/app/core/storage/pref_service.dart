import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PrefService extends GetxService {
  static PrefService get to => Get.find<PrefService>();

  final _box = GetStorage();

  static const _tokenKey = "token";

  Future<PrefService> init() async {
    await GetStorage.init();
    return this;
  }

  Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  String? getToken() {
    return _box.read<String>(_tokenKey);
  }

  Future<void> clearToken() async {
    await _box.remove(_tokenKey);
  }
}