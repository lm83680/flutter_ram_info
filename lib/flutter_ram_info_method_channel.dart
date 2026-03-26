import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ram_info_platform_interface.dart';

class MethodChannelFlutterRamInfo extends FlutterRamInfoPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ram_info');

  @override
  Future<String?> getPlatformVersion() async {
    return methodChannel.invokeMethod<String>('getPlatformVersion');
  }

  @override
  Future<int?> getFreeRamMB() async {
    return methodChannel.invokeMethod<int>('getFreeRamMB');
  }

  @override
  Future<int?> getTotalRamMB() async {
    return methodChannel.invokeMethod<int>('getTotalRamMB');
  }
}
