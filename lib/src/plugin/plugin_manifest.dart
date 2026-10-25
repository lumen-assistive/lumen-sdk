import 'package:meta/meta.dart';

import 'plugin_capability.dart';

/// Static description of a plugin, independent of any running instance.
///
/// `lumen-core` reads the manifest before instantiating a plugin to
/// decide whether the user's device and consent state allow it to run,
/// and to render the module's entry in onboarding and settings.
@immutable
class PluginManifest {
  /// Creates a plugin manifest.
  const PluginManifest({
    required this.id,
    required this.nameIt,
    required this.nameEn,
    required this.version,
    required this.sdkConstraint,
    required this.capabilities,
  });

  /// Stable, lowercase, hyphenated identifier, for example `vision`.
  final String id;

  /// Display name shown to Italian-speaking users, the app's primary
  /// locale.
  final String nameIt;

  /// Display name shown when the active locale falls back to English.
  final String nameEn;

  /// This plugin's own version, following Semantic Versioning.
  final String version;

  /// The `lumen_sdk` version constraint this plugin was built against,
  /// for example `^0.1.0`. `lumen-core` refuses to load a plugin whose
  /// constraint it does not satisfy rather than risk a silent contract
  /// mismatch.
  final String sdkConstraint;

  /// Capabilities `lumen-core` must mediate access to on this plugin's
  /// behalf before it is allowed to start.
  final List<PluginCapability> capabilities;
}
