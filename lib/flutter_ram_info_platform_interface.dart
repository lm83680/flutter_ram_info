import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ram_info_method_channel.dart';

abstract class FlutterRamInfoPlatform extends PlatformInterface {
  FlutterRamInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRamInfoPlatform _instance = MethodChannelFlutterRamInfo();

  static FlutterRamInfoPlatform get instance => _instance;

  static set instance(FlutterRamInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<int?> getFreeRamMB() {
    throw UnimplementedError('getFreeRamMB() has not been implemented.');
  }

  Future<int?> getTotalRamMB() {
    throw UnimplementedError('getTotalRamMB() has not been implemented.');
  }
}
