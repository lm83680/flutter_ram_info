import Flutter
import UIKit
import Darwin.Mach

public class FlutterRamInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_ram_info", binaryMessenger: registrar.messenger())
    let instance = FlutterRamInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getFreeRamMB":
      result(getFreeRamMB())
    case "getTotalRamMB":
      result(getTotalRamMB())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getFreeRamMB() -> Int? {
    guard let vmStats = readVmStatistics() else {
      return nil
    }

    let freeBytes = Double(vm_page_size) * Double(vmStats.free_count + vmStats.inactive_count)
    return bytesToRoundedMB(freeBytes)
  }

  private func getTotalRamMB() -> Int {
    let totalBytes = Double(ProcessInfo.processInfo.physicalMemory)
    return bytesToRoundedMB(totalBytes)
  }

  private func bytesToRoundedMB(_ bytes: Double) -> Int {
    return Int((bytes / (1024.0 * 1024.0)).rounded())
  }

  private func readVmStatistics() -> vm_statistics64? {
    var size = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
    var hostInfo = vm_statistics64()

    let hostPort: host_t = mach_host_self()
    let status = withUnsafeMutablePointer(to: &hostInfo) { pointer in
      pointer.withMemoryRebound(to: integer_t.self, capacity: Int(size)) { reboundPointer in
        host_statistics64(hostPort, HOST_VM_INFO64, reboundPointer, &size)
      }
    }

    if status == KERN_SUCCESS {
      return hostInfo
    }

    return nil
  }
}
