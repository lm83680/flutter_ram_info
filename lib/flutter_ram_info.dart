import 'flutter_ram_info_platform_interface.dart';

class FlutterRamInfo {
  Future<String?> getPlatformVersion() {
    return FlutterRamInfoPlatform.instance.getPlatformVersion();
  }

  Future<int?> getFreeRamMB() {
    return FlutterRamInfoPlatform.instance.getFreeRamMB();
  }

  Future<int?> getTotalRamMB() {
    return FlutterRamInfoPlatform.instance.getTotalRamMB();
  }
}
