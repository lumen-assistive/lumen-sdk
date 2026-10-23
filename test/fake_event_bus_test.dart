import 'package:lumen_sdk/lumen_sdk.dart';
import 'package:lumen_sdk/lumen_sdk_testing.dart';
import 'package:test/test.dart';

void main() {
  group('FakeEventBus', () {
    late FakeEventBus bus;

    setUp(() {
      bus = FakeEventBus();
    });

    tearDown(() async {
      await bus.close();
    });

    test('delivers published events only to matching subscribers', () async {
      final transcripts = <TranscriptEvent>[];
      final alerts = <AlertEvent>[];

      bus.on<TranscriptEvent>().listen(transcripts.add);
      bus.on<AlertEvent>().listen(alerts.add);

      final transcript = TranscriptEvent(
        timestamp: DateTime(2026),
        text: 'Ciao',
        isFinal: true,
      );
      bus.publish(transcript);

      // Give the broadcast stream a turn to deliver the event.
      await Future<void>.delayed(Duration.zero);

      expect(transcripts, [transcript]);
      expect(alerts, isEmpty);
    });

    test('supports multiple subscribers to the same event type', () async {
      final firstReceived = <TranscriptEvent>[];
      final secondReceived = <TranscriptEvent>[];

      bus.on<TranscriptEvent>().listen(firstReceived.add);
      bus.on<TranscriptEvent>().listen(secondReceived.add);

      final transcript = TranscriptEvent(
        timestamp: DateTime(2026),
        text: 'Ciao',
        isFinal: false,
      );
      bus.publish(transcript);

      await Future<void>.delayed(Duration.zero);

      expect(firstReceived, [transcript]);
      expect(secondReceived, [transcript]);
    });
  });
}
