import 'package:meta/meta.dart';

/// Base type for every event carried on the `LumenEventBus`.
///
/// Subclasses live in this package so that `lumen-core` and plugins
/// share a single, versioned catalog of event shapes instead of each
/// defining their own.
@immutable
abstract class SenseEvent {
  /// Creates a sense event stamped with [timestamp].
  const SenseEvent({required this.timestamp});

  /// When `lumen-core` captured or produced this event, device clock.
  final DateTime timestamp;
}
