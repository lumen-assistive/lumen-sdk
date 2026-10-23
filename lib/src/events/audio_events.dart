import 'sense_event.dart';

/// A chunk of raw PCM audio captured from the microphone: 16-bit
/// signed, mono, at [sampleRate] Hz.
///
/// `lumen-core` publishes these; plugins never open the microphone
/// directly.
class AudioChunkEvent extends SenseEvent {
  /// Creates an audio chunk event.
  const AudioChunkEvent({
    required super.timestamp,
    required this.sampleRate,
    required this.samples,
  });

  /// Sample rate of [samples], in Hz.
  final int sampleRate;

  /// Signed 16-bit PCM samples.
  final List<int> samples;
}

/// A transcribed segment of speech, optionally attributed to a speaker.
class TranscriptEvent extends SenseEvent {
  /// Creates a transcript event.
  const TranscriptEvent({
    required super.timestamp,
    required this.text,
    required this.isFinal,
    this.speakerId,
  });

  /// The transcribed text.
  final String text;

  /// Whether this segment is final or may still be revised by the
  /// speech recognizer. Live captioning emits non-final segments first.
  final bool isFinal;

  /// Identifier from on-device speaker diarization, when available.
  final String? speakerId;
}

/// A recognized non-speech sound of interest, classified on-device:
/// doorbell, smoke alarm, siren, baby crying, and similar.
class SoundAlertEvent extends SenseEvent {
  /// Creates a sound alert event.
  const SoundAlertEvent({
    required super.timestamp,
    required this.label,
    required this.confidence,
  });

  /// Stable identifier of the recognized sound class, for example
  /// `smoke_alarm`.
  final String label;

  /// Confidence reported by the underlying classifier, from `0.0` to
  /// `1.0`.
  final double confidence;
}
