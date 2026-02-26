import 'package:get/get.dart';
import '../core/storage/pref_service.dart';
import '../../services/auth_service.dart';
import '../core/network/dio_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {

    Get.put(DioClient(), permanent: true);

    /// 🔥 PrefService init
    await Get.putAsync<PrefService>(() async => PrefService().init());

    Get.put(AuthService(), permanent: true);
  }
}