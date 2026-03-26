# flutter_ram_info

一个用于在 Flutter 侧统一获取设备内存信息的插件，支持 Android、iOS、OHOS。
开箱即用，无需任何权限

## 功能

- `getFreeRamMB()`：获取当前可用 RAM（MB，四舍五入）
- `getTotalRamMB()`：获取总 RAM（MB，四舍五入）

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  flutter_ram_info: 
```

## 使用示例

```dart
import 'package:flutter_ram_info/flutter_ram_info.dart';

final FlutterRamInfo ramInfo = FlutterRamInfo();
final int? freeRamMB = await ramInfo.getFreeRamMB();
final int? totalRamMB = await ramInfo.getTotalRamMB();
```

## 平台说明

### Android

使用 `ActivityManager.MemoryInfo` 获取可用/总内存。

### iOS

- 可用内存：基于 `host_statistics64` 读取内存页统计
- 总内存：使用 `ProcessInfo.processInfo.physicalMemory`

### OHOS

使用 import { hidebug } from '@kit.PerformanceAnalysisKit';

```ts
let memory = hidebug.getSystemMemInfo();
let availableMem = memory.availableMem;
let freeMem = memory.freeMem;
let totalMem = memory.totalMem;
```