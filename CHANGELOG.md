# Changelog

All notable changes to this project are documented in this file. The
format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org).

## [Unreleased]

## [0.1.0] - 2026-10-23

### Added

- `LumenPlugin` lifecycle contract (`initialize`, `start`, `stop`,
  `dispose`) and `PluginManifest`/`PluginCapability`.
- `LumenEventBus` typed publish/subscribe contract and the sense event
  catalog: `VisionFrameEvent`, `OcrResultEvent`, `AudioChunkEvent`,
  `TranscriptEvent`, `SoundAlertEvent`, `AlertEvent`.
- `ModelRegistry`/`ModelHandle`/`ModelDescriptor`/`ModelTask` contracts
  for on-demand model loading.
- `lumen_sdk_testing` entry point with `FakeEventBus`,
  `FakeModelRegistry`, and `FakePluginContext` for unit testing plugins
  without `lumen-core`.
- A runnable example plugin at `example/example_plugin.dart`.
