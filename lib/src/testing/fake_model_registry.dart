import '../models/model_descriptor.dart';
import '../models/model_registry.dart';

/// In-memory [ModelRegistry] for unit testing plugins without
/// `lumen-core`.
///
/// Every descriptor passed to the constructor is reported as already
/// downloaded, so tests do not need to simulate a download step unless
/// they explicitly want to exercise the "not yet downloaded" path by
/// omitting a descriptor.
class FakeModelRegistry implements ModelRegistry {
  /// Creates a fake registry seeded with [descriptors].
  FakeModelRegistry(List<ModelDescriptor> descriptors)
    : _descriptors = List.of(descriptors);

  final List<ModelDescriptor> _descriptors;
  final Set<String> _acquiredIds = {};

  @override
  List<ModelDescriptor> listAvailable() => List.unmodifiable(_descriptors);

  @override
  bool isDownloaded(String modelId) =>
      _descriptors.any((descriptor) => descriptor.id == modelId);

  @override
  Future<void> ensureDownloaded(String modelId) async {
    if (!isDownloaded(modelId)) {
      throw StateError('Unknown model id: $modelId');
    }
  }

  @override
  Future<ModelHandle> acquire(String modelId) async {
    final descriptor = _descriptors.firstWhere(
      (descriptor) => descriptor.id == modelId,
      orElse: () => throw StateError('Unknown model id: $modelId'),
    );
    _acquiredIds.add(modelId);
    return _FakeModelHandle(descriptor, onDispose: () {
      _acquiredIds.remove(modelId);
    });
  }

  /// Whether [modelId] was acquired and not yet disposed.
  ///
  /// Useful to assert that a plugin releases model handles in its
  /// `stop` method.
  bool isAcquired(String modelId) => _acquiredIds.contains(modelId);
}

class _FakeModelHandle implements ModelHandle {
  _FakeModelHandle(this.descriptor, {required this.onDispose});

  @override
  final ModelDescriptor descriptor;

  final void Function() onDispose;
  bool _disposed = false;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    onDispose();
  }
}
