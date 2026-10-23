import 'plugin_context.dart';
import 'plugin_manifest.dart';

/// Lifecycle contract every Lumen module implements.
///
/// `lumen-core` owns the lifecycle: it constructs a plugin, calls
/// [initialize] once a [PluginContext] is ready, calls [start] when the
/// user enables the module, [stop] when they disable it or navigate
/// away, and [dispose] when the plugin is being unloaded entirely, for
/// example during an SDK version migration.
abstract class LumenPlugin {
  /// Static metadata describing this plugin.
  ///
  /// Must not depend on any runtime state, since `lumen-core` reads it
  /// before calling [initialize].
  PluginManifest get manifest;

  /// Called once per process, before [start].
  ///
  /// Use this to validate that required model handles can be resolved;
  /// do not begin consuming sense data yet.
  Future<void> initialize(PluginContext context);

  /// Called when the module becomes active.
  ///
  /// Subscribe to the event bus and begin doing work here.
  Future<void> start();

  /// Called when the module becomes inactive.
  ///
  /// Unsubscribe from the event bus and release any model handles
  /// acquired in [start].
  Future<void> stop();

  /// Called when the plugin will not be used again in this process.
  ///
  /// Release any resources acquired in [initialize].
  Future<void> dispose();
}
