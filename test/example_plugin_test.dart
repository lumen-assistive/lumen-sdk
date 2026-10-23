import 'package:lumen_sdk/lumen_sdk.dart';
import 'package:lumen_sdk/lumen_sdk_testing.dart';
import 'package:test/test.dart';

import '../example/example_plugin.dart';

void main() {
  group('ExamplePlugin', () {
    late ExamplePlugin plugin;
    late FakePluginContext context;

    setUp(() async {
      plugin = ExamplePlugin();
      context = FakePluginContext();
      await plugin.initialize(context);
    });

    tearDown(() async {
      await plugin.dispose();
    });

    test('declares the microphone capability', () {
      expect(plugin.manifest.capabilities, [PluginCapability.microphone]);
    });

    test('raises a critical alert on a final "aiuto" transcript', () async {
      await plugin.start();

      final nextAlert = context.eventBus.on<AlertEvent>().first;
      context.eventBus.publish(
        TranscriptEvent(
          timestamp: DateTime(2026),
          text: 'Aiuto, per favore!',
          isFinal: true,
        ),
      );

      final alert = await nextAlert;
      expect(alert.pluginId, 'example');
      expect(alert.severity, AlertSeverity.critical);
    });

    test('ignores non-final transcripts', () async {
      await plugin.start();

      var alertCount = 0;
      context.eventBus.on<AlertEvent>().listen((_) => alertCount++);

      context.eventBus.publish(
        TranscriptEvent(
          timestamp: DateTime(2026),
          text: 'Aiuto',
          isFinal: false,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(alertCount, 0);
    });

    test('stops delivering alerts after stop', () async {
      await plugin.start();
      await plugin.stop();

      var alertCount = 0;
      context.eventBus.on<AlertEvent>().listen((_) => alertCount++);

      context.eventBus.publish(
        TranscriptEvent(
          timestamp: DateTime(2026),
          text: 'Aiuto!',
          isFinal: true,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(alertCount, 0);
    });
  });
}
