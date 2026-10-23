/// A device or model capability a plugin declares it needs.
///
/// `lumen-core` mediates every capability a plugin uses: it requests the
/// corresponding operating system permission, shows the consent prompt,
/// and only then routes the matching sense data to the plugin. A plugin
/// never requests a permission from the operating system itself.
enum PluginCapability {
  /// Access to camera frames, routed through `lumen-core` as
  /// `VisionFrameEvent`s.
  camera,

  /// Access to microphone audio, routed through `lumen-core` as
  /// `AudioChunkEvent`s.
  microphone,

  /// Access to the device's location, used for example by Protezione's
  /// offline SOS flow.
  location,

  /// Permission to show local notifications.
  notifications,

  /// Permission to read incoming SMS, used by the scam filter.
  smsRead,

  /// Permission to send SMS, used by the offline SOS flow.
  smsSend,

  /// Access to the contacts list, used to resolve emergency contacts.
  contacts,

  /// Access to on-device storage outside the app's private directory.
  storage,
}
