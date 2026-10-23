import 'package:lumen_sdk/lumen_sdk_testing.dart';
import 'package:test/test.dart';

void main() {
  group('FakePluginContext', () {
    test('reports no consent granted by default', () {
      final context = FakePluginContext();

      expect(context.hasConsent('share-location-with-caregiver'), isFalse);
    });

    test('reports consent for keys passed at construction', () {
      final context = FakePluginContext(
        grantedConsents: {'share-location-with-caregiver'},
      );

      expect(context.hasConsent('share-location-with-caregiver'), isTrue);
      expect(context.hasConsent('share-transcripts'), isFalse);
    });

    test('defaults to fresh fakes when none are provided', () {
      final context = FakePluginContext();

      expect(context.eventBus, isA<FakeEventBus>());
      expect(context.modelRegistry, isA<FakeModelRegistry>());
    });
  });
}
