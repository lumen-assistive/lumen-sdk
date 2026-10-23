// Minimal runnable example of a Lumen plugin, meant as the starting
// template for a new module. Copy this file's structure into a new
// `lumen-plugin-*` repository and replace the trivial keyword match
// below with a real on-device model obtained through
// `PluginContext.modelRegistry`.
import 'dart:async';

import 'package:lumen_sdk/lumen_sdk.dart';
import 'package:lumen_sdk/lumen_sdk_testing.dart';

/// Listens for final transcript segments containing the Italian word
/// for "help" and raises a critical alert.
class ExamplePlugin implements LumenPlugin {
  StreamSubscription<TranscriptEvent>? _subscription;
  late PluginContext _context;

  @override
  final PluginManifest manifest = const PluginManifest(
    id: 'example',
    nameIt: 'Esempio',
    nameEn: 'Example',
    version: '0.1.0',
    sdkConstraint: '^0.1.0',
    capabilities: [PluginCapability.microphone],
  );

  @override
  Future<void> initialize(PluginContext context) async {
    _context = context;
  }

  @override
  Future<void> start() async {
    _subscription = _context.eventBus.on<TranscriptEvent>().listen((event) {
      if (event.isFinal && event.text.toLowerCase().contains('aiuto')) {
        _context.eventBus.publish(
          AlertEvent(
            timestamp: DateTime.now(),
            pluginId: manifest.id,
            severity: AlertSeverity.critical,
            messageIt: 'È stata rilevata una richiesta di aiuto.',
            messageEn: 'A request for help was detected.',
          ),
        );
      }
    });
  }

  @override
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> dispose() async {
    await stop();
  }
}

Future<void> main() async {
  final plugin = ExamplePlugin();
  final context = FakePluginContext();

  await plugin.initialize(context);
  await plugin.start();

  final nextAlert = context.eventBus.on<AlertEvent>().first;

  context.eventBus.publish(
    TranscriptEvent(
      timestamp: DateTime.now(),
      text: 'Aiuto!',
      isFinal: true,
    ),
  );

  final alert = await nextAlert;
  // ignore: avoid_print
  print('${alert.pluginId}: ${alert.messageEn}');

  await plugin.stop();
}
