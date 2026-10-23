import '../events/lumen_event_bus.dart';
import '../models/model_registry.dart';
import '../plugin/plugin_context.dart';
import 'fake_event_bus.dart';
import 'fake_model_registry.dart';

/// In-memory [PluginContext] for unit testing plugins without
/// `lumen-core`.
class FakePluginContext implements PluginContext {
  /// Creates a fake plugin context.
  ///
  /// Defaults to a fresh [FakeEventBus] and an empty [FakeModelRegistry]
  /// when not provided, and to no granted consents.
  FakePluginContext({
    LumenEventBus? eventBus,
    ModelRegistry? modelRegistry,
    Set<String> grantedConsents = const {},
  }) : eventBus = eventBus ?? FakeEventBus(),
       modelRegistry = modelRegistry ?? FakeModelRegistry(const []),
       _grantedConsents = grantedConsents;

  @override
  final LumenEventBus eventBus;

  @override
  final ModelRegistry modelRegistry;

  final Set<String> _grantedConsents;

  @override
  bool hasConsent(String consentKey) => _grantedConsents.contains(consentKey);
}
