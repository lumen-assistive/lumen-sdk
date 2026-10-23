import 'package:meta/meta.dart';

import 'model_task.dart';

/// Describes a downloadable model pack without loading it.
///
/// [licenseId] must match an entry in `lumen-models/LICENSES.md`. This
/// package does not interpret license text; it only carries the
/// identifier so that `lumen-core` and `lumen-app` can surface it to the
/// user and refuse to bundle a model whose license has not been
/// cleared.
@immutable
class ModelDescriptor {
  /// Creates a model descriptor.
  const ModelDescriptor({
    required this.id,
    required this.task,
    required this.quantization,
    required this.sizeBytes,
    required this.licenseId,
    required this.version,
  });

  /// Stable identifier of this model pack.
  final String id;

  /// The inference task this model performs.
  final ModelTask task;

  /// Quantization applied to this model pack, for example `int8`,
  /// `fp16`, or `none` for models distributed unquantized.
  final String quantization;

  /// Size of the model pack on disk, in bytes.
  final int sizeBytes;

  /// Identifier of this model's license entry in
  /// `lumen-models/LICENSES.md`.
  final String licenseId;

  /// This model pack's own version.
  final String version;
}
