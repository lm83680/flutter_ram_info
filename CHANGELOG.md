## 0.0.1

- 初始化 `flutter_ram_info` 插件，支持 Android、iOS、OHOS。
- 新增统一 Flutter API：`getFreeRamMB()`、`getTotalRamMB()`。
- Android 端基于 `ActivityManager.MemoryInfo` 获取可用/总 RAM。
- iOS 端基于 `host_statistics64` 与 `ProcessInfo` 获取可用/总 RAM。
- OHOS 端基于 `deviceManager.getAvailableMem()` 与 `getTotalMem()` 获取可用/总 RAM。
- 增加 OHOS 权限声明：`ohos.permission.GET_DEVICE_INFO`。
- 更新示例应用与单元测试。
