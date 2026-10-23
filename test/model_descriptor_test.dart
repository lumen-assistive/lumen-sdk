import 'package:lumen_sdk/lumen_sdk.dart';
import 'package:lumen_sdk/lumen_sdk_testing.dart';
import 'package:test/test.dart';

const _whisperTiny = ModelDescriptor(
  id: 'whisper-tiny-it',
  task: ModelTask.automaticSpeechRecognition,
  quantization: 'int8',
  sizeBytes: 42000000,
  licenseId: 'whisper-mit',
  version: '1.0.0',
);

void main() {
  group('ModelDescriptor', () {
    test('exposes every field passed to the constructor', () {
      expect(_whisperTiny.id, 'whisper-tiny-it');
      expect(_whisperTiny.task, ModelTask.automaticSpeechRecognition);
      expect(_whisperTiny.quantization, 'int8');
      expect(_whisperTiny.sizeBytes, 42000000);
      expect(_whisperTiny.licenseId, 'whisper-mit');
      expect(_whisperTiny.version, '1.0.0');
    });
  });

  group('FakeModelRegistry', () {
    test('reports seeded descriptors as downloaded', () {
      final registry = FakeModelRegistry([_whisperTiny]);

      expect(registry.listAvailable(), [_whisperTiny]);
      expect(registry.isDownloaded('whisper-tiny-it'), isTrue);
      expect(registry.isDownloaded('unknown'), isFalse);
    });

    test('ensureDownloaded throws for an unknown model', () {
      final registry = FakeModelRegistry(const []);

      expect(
        () => registry.ensureDownloaded('unknown'),
        throwsStateError,
      );
    });

    test('acquire tracks acquisition until disposed', () async {
      final registry = FakeModelRegistry([_whisperTiny]);

      final handle = await registry.acquire('whisper-tiny-it');
      expect(handle.descriptor, _whisperTiny);
      expect(registry.isAcquired('whisper-tiny-it'), isTrue);

      await handle.dispose();
      expect(registry.isAcquired('whisper-tiny-it'), isFalse);

      // Disposing twice must not throw.
      await handle.dispose();
    });

    test('acquire throws for an unknown model', () {
      final registry = FakeModelRegistry(const []);

      expect(() => registry.acquire('unknown'), throwsStateError);
    });
  });
}
