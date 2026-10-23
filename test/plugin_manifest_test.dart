import 'package:lumen_sdk/lumen_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('PluginManifest', () {
    test('exposes every field passed to the constructor', () {
      const manifest = PluginManifest(
        id: 'vedere',
        nameIt: 'Vedere',
        nameEn: 'See',
        version: '1.2.0',
        sdkConstraint: '^0.1.0',
        capabilities: [PluginCapability.camera],
      );

      expect(manifest.id, 'vedere');
      expect(manifest.nameIt, 'Vedere');
      expect(manifest.nameEn, 'See');
      expect(manifest.version, '1.2.0');
      expect(manifest.sdkConstraint, '^0.1.0');
      expect(manifest.capabilities, [PluginCapability.camera]);
    });

    test('allows an empty capability list', () {
      const manifest = PluginManifest(
        id: 'famiglia',
        nameIt: 'Famiglia',
        nameEn: 'Family',
        version: '0.1.0',
        sdkConstraint: '^0.1.0',
        capabilities: [],
      );

      expect(manifest.capabilities, isEmpty);
    });
  });
}
