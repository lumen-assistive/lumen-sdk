/// The kind of inference a model pack performs.
enum ModelTask {
  /// Optical character recognition.
  ocr,

  /// Automatic speech recognition.
  automaticSpeechRecognition,

  /// Classification of non-speech sounds.
  soundClassification,

  /// On-device text to speech synthesis.
  textToSpeech,

  /// Detection of objects or obstacles in a camera frame.
  objectDetection,

  /// A small, on-device language model used for tasks such as leaflet
  /// question answering.
  smallLanguageModel,
}
