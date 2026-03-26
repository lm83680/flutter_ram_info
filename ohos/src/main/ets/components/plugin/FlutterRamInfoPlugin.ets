import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import hidebug from '@ohos.hidebug';

export default class FlutterRamInfoPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  getUniqueClassName(): string {
    return 'FlutterRamInfoPlugin';
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), 'flutter_ram_info');
    this.channel.setMethodCallHandler(this);
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel !== null) {
      this.channel.setMethodCallHandler(null);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method === 'getPlatformVersion') {
      result.success('OpenHarmony');
      return;
    }

    if (call.method === 'getFreeRamMB') {
      result.success(this.getFreeRamMB());
      return;
    }

    if (call.method === 'getTotalRamMB') {
      result.success(this.getTotalRamMB());
      return;
    }

    result.notImplemented();
  }

  private getFreeRamMB(): number | null {
    try {
      const memInfo = hidebug.getSystemMemInfo();
      const freeRamMB = memInfo.availableMem / 1024n;
      return Number(freeRamMB);
    } catch {
      return null;
    }
  }

  private getTotalRamMB(): number | null {
    try {
      const memInfo = hidebug.getSystemMemInfo();
      const totalRamMB = memInfo.totalMem / 1024n;
      return Number(totalRamMB);
    } catch {
      return null;
    }
  }
}
