import 'package:flutter/services.dart';
import 'package:flutter_ram_info/flutter_ram_info_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelFlutterRamInfo platform = MethodChannelFlutterRamInfo();
  const MethodChannel channel = MethodChannel('flutter_ram_info');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getPlatformVersion':
            return '42';
          case 'getFreeRamMB':
            return 3072;
          case 'getTotalRamMB':
            return 12288;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getFreeRamMB', () async {
    expect(await platform.getFreeRamMB(), 3072);
  });

  test('getTotalRamMB', () async {
    expect(await platform.getTotalRamMB(), 12288);
  });
}
