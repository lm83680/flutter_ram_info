import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ram_info/flutter_ram_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterRamInfo _ramInfoPlugin = FlutterRamInfo();

  String _platformVersion = 'Unknown';
  String _freeRam = 'Unknown';
  String _totalRam = 'Unknown';

  @override
  void initState() {
    super.initState();
    _loadRamInfo();
  }

  Future<void> _loadRamInfo() async {
    String platformVersion = 'Unknown platform version';
    String freeRam = 'Unknown';
    String totalRam = 'Unknown';

    try {
      platformVersion = await _ramInfoPlugin.getPlatformVersion() ?? platformVersion;
      final int? freeRamMB = await _ramInfoPlugin.getFreeRamMB();
      final int? totalRamMB = await _ramInfoPlugin.getTotalRamMB();
      freeRam = freeRamMB == null ? 'Unavailable' : '$freeRamMB MB';
      totalRam = totalRamMB == null ? 'Unavailable' : '$totalRamMB MB';
    } on PlatformException catch (error) {
      freeRam = 'Error: ${error.message ?? 'unknown'}';
      totalRam = 'Error: ${error.message ?? 'unknown'}';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = platformVersion;
      _freeRam = freeRam;
      _totalRam = totalRam;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('RAM Info Example')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Platform: $_platformVersion'),
              const SizedBox(height: 8),
              Text('Free RAM: $_freeRam'),
              const SizedBox(height: 8),
              Text('Total RAM: $_totalRam'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _loadRamInfo,
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
