import 'sense_event.dart';

/// How urgently an [AlertEvent] should be surfaced to the user.
enum AlertSeverity {
  /// Informational; no immediate action needed.
  info,

  /// The user should be made aware soon, but it is not an emergency.
  warning,

  /// Requires immediate attention, for example a detected fall or a
  /// smoke alarm.
  critical,
}

/// A user-facing alert any plugin can publish.
///
/// `lumen-app` consumes these to drive visual, haptic and audible
/// notification consistently regardless of which module raised the
/// alert.
class AlertEvent extends SenseEvent {
  /// Creates an alert event.
  const AlertEvent({
    required super.timestamp,
    required this.pluginId,
    required this.severity,
    required this.messageIt,
    required this.messageEn,
  });

  /// `PluginManifest.id` of the plugin that raised this alert.
  final String pluginId;

  /// How urgently this alert should be surfaced.
  final AlertSeverity severity;

  /// Message shown to Italian-speaking users, the app's primary locale.
  final String messageIt;

  /// Message shown when the active locale falls back to English.
  final String messageEn;
}
