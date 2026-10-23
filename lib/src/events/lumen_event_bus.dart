import 'sense_event.dart';

/// Typed publish/subscribe contract plugins use instead of touching
/// sensors directly.
///
/// `lumen-core` provides the implementation; plugins only ever see this
/// interface, which keeps every module testable with an in-memory fake
/// and keeps sensor access centralized for consent and power
/// management.
abstract class LumenEventBus {
  /// Subscribes to every event of type [T].
  ///
  /// The returned stream is broadcast. Cancel the subscription in
  /// `LumenPlugin.stop`.
  Stream<T> on<T extends SenseEvent>();

  /// Publishes [event] to every current subscriber of its runtime type.
  void publish(SenseEvent event);
}
