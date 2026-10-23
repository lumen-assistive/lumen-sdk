import 'model_descriptor.dart';

/// Opaque, disposable handle to a loaded model instance.
///
/// Plugins never load models directly; they request a handle from
/// [ModelRegistry] and release it with [dispose] so `lumen-core` can
/// unload models that are no longer needed and bound device memory use.
abstract class ModelHandle {
  /// The descriptor this handle was acquired for.
  ModelDescriptor get descriptor;

  /// Releases the underlying native resources. Safe to call more than
  /// once.
  Future<void> dispose();
}

/// Central place plugins obtain model handles from, so that model
/// loading, on-demand download, quantization selection and memory
/// limits stay implemented once in `lumen-core`.
abstract class ModelRegistry {
  /// Descriptors for every model pack currently known, whether or not
  /// it has been downloaded yet.
  List<ModelDescriptor> listAvailable();

  /// Whether the given model's files are present on-device and
  /// verified.
  bool isDownloaded(String modelId);

  /// Downloads the given model pack if not already present.
  ///
  /// Does nothing if the required network consent has not been granted.
  Future<void> ensureDownloaded(String modelId);

  /// Loads and returns a handle to the given model.
  ///
  /// Throws a [StateError] if the model has not been downloaded yet;
  /// callers must call [ensureDownloaded] first.
  Future<ModelHandle> acquire(String modelId);
}
