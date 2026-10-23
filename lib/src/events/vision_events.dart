import 'sense_event.dart';

/// A single camera frame made available for on-device vision models.
///
/// `lumen-core` publishes these; plugins never open the camera
/// directly. The frame is kept in its native plane layout (YUV420 on
/// Android, BGRA on iOS) rather than decoded, so that the costly decode
/// step happens once in `lumen-core` for whichever plugin actually
/// needs a decoded image.
class VisionFrameEvent extends SenseEvent {
  /// Creates a vision frame event.
  const VisionFrameEvent({
    required super.timestamp,
    required this.width,
    required this.height,
    required this.bytesPerRow,
    required this.planeBytes,
  });

  /// Frame width in pixels.
  final int width;

  /// Frame height in pixels.
  final int height;

  /// Stride of a single row in [planeBytes], in bytes.
  final int bytesPerRow;

  /// Raw plane data in the platform's native camera image format.
  final List<int> planeBytes;
}

/// Result of on-device OCR over a single frame or captured photo.
class OcrResultEvent extends SenseEvent {
  /// Creates an OCR result event.
  const OcrResultEvent({
    required super.timestamp,
    required this.text,
    required this.confidence,
  });

  /// The recognized text.
  final String text;

  /// Confidence reported by the underlying OCR model, from `0.0` (no
  /// confidence) to `1.0` (full confidence).
  final double confidence;
}
