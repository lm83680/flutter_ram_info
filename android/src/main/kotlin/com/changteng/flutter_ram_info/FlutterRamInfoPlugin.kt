package com.changteng.flutter_ram_info

import android.app.ActivityManager
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.math.roundToInt

class FlutterRamInfoPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_ram_info")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getFreeRamMB" -> result.success(getAvailableRamMB())
      "getTotalRamMB" -> result.success(getTotalRamMB())
      else -> result.notImplemented()
    }
  }

  private fun getAvailableRamMB(): Int {
    val memoryInfo = queryMemoryInfo()
    return bytesToMb(memoryInfo.availMem)
  }

  private fun getTotalRamMB(): Int {
    val memoryInfo = queryMemoryInfo()
    return bytesToMb(memoryInfo.totalMem)
  }

  private fun queryMemoryInfo(): ActivityManager.MemoryInfo {
    val activityManager = applicationContext.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
    val memoryInfo = ActivityManager.MemoryInfo()
    activityManager.getMemoryInfo(memoryInfo)
    return memoryInfo
  }

  private fun bytesToMb(bytes: Long): Int {
    val mbValue = bytes.toDouble() / (1024.0 * 1024.0)
    return mbValue.roundToInt()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
