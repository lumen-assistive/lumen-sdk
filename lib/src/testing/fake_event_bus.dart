import 'dart:async';

import '../events/lumen_event_bus.dart';
import '../events/sense_event.dart';

/// In-memory [LumenEventBus] for unit testing plugins without
/// `lumen-core`.
///
/// Not intended for production use: there is no backpressure, no
/// consent enforcement and no sensor access behind it.
class FakeEventBus implements LumenEventBus {
  final Map<Type, StreamController<SenseEvent>> _controllers = {};

  StreamController<SenseEvent> _controllerFor(Type type) {
    return _controllers.putIfAbsent(
      type,
      () => StreamController<SenseEvent>.broadcast(),
    );
  }

  @override
  Stream<T> on<T extends SenseEvent>() {
    return _controllerFor(T).stream.cast<T>();
  }

  @override
  void publish(SenseEvent event) {
    _controllerFor(event.runtimeType).add(event);
  }

  /// Closes every underlying stream controller.
  ///
  /// Call this from a test's `tearDown` to avoid leaking open streams
  /// between tests.
  Future<void> close() async {
    for (final controller in _controllers.values) {
      await controller.close();
    }
    _controllers.clear();
  }
}
