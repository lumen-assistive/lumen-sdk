import '../events/lumen_event_bus.dart';
import '../models/model_registry.dart';

/// Everything a plugin receives from `lumen-core` at initialization.
///
/// A plugin must not reach for sensors, platform channels or model
/// files on its own; every capability it needs arrives through this
/// context, which keeps `lumen-core` the single place that mediates
/// hardware and model access and enforces user consent.
abstract class PluginContext {
  /// The shared event bus plugins subscribe to for sense data and
  /// publish alerts to.
  LumenEventBus get eventBus;

  /// The shared model registry plugins use to request on-demand model
  /// handles instead of loading models themselves.
  ModelRegistry get modelRegistry;

  /// Reads a previously granted consent flag, for example whether the
  /// user has allowed this plugin to share data with a paired
  /// caregiver.
  bool hasConsent(String consentKey);
}
