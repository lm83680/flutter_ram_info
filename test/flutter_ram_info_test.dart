import 'package:flutter_ram_info/flutter_ram_info.dart';
import 'package:flutter_ram_info/flutter_ram_info_method_channel.dart';
import 'package:flutter_ram_info/flutter_ram_info_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterRamInfoPlatform with MockPlatformInterfaceMixin implements FlutterRamInfoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future<String?>.value('42');

  @override
  Future<int?> getFreeRamMB() => Future<int?>.value(2048);

  @override
  Future<int?> getTotalRamMB() => Future<int?>.value(8192);
}

void main() {
  final FlutterRamInfoPlatform initialPlatform = FlutterRamInfoPlatform.instance;

  test('$MethodChannelFlutterRamInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterRamInfo>());
  });

  test('getPlatformVersion', () async {
    final FlutterRamInfo plugin = FlutterRamInfo();
    final MockFlutterRamInfoPlatform fakePlatform = MockFlutterRamInfoPlatform();
    FlutterRamInfoPlatform.instance = fakePlatform;

    expect(await plugin.getPlatformVersion(), '42');
  });

  test('getFreeRamMB', () async {
    final FlutterRamInfo plugin = FlutterRamInfo();
    final MockFlutterRamInfoPlatform fakePlatform = MockFlutterRamInfoPlatform();
    FlutterRamInfoPlatform.instance = fakePlatform;

    expect(await plugin.getFreeRamMB(), 2048);
  });

  test('getTotalRamMB', () async {
    final FlutterRamInfo plugin = FlutterRamInfo();
    final MockFlutterRamInfoPlatform fakePlatform = MockFlutterRamInfoPlatform();
    FlutterRamInfoPlatform.instance = fakePlatform;

    expect(await plugin.getTotalRamMB(), 8192);
  });
}
