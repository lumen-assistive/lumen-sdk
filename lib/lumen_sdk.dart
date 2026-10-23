/// Plugin SDK for Lumen: the plugin interface, event bus and model
/// registry contracts shared by `lumen-core`, `lumen-app` and every
/// Lumen module.
library;

export 'src/events/alert_event.dart';
export 'src/events/audio_events.dart';
export 'src/events/lumen_event_bus.dart';
export 'src/events/sense_event.dart';
export 'src/events/vision_events.dart';
export 'src/models/model_descriptor.dart';
export 'src/models/model_registry.dart';
export 'src/models/model_task.dart';
export 'src/plugin/lumen_plugin.dart';
export 'src/plugin/plugin_capability.dart';
export 'src/plugin/plugin_context.dart';
export 'src/plugin/plugin_manifest.dart';
