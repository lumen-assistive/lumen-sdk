# lumen_sdk

The plugin SDK for [Lumen](https://github.com/lumen-assistive), an
open source, offline-first assistive app. This package defines the
contracts every Lumen module depends on:

- **`LumenPlugin`**: the lifecycle every module implements
  (`initialize`, `start`, `stop`, `dispose`).
- **`LumenEventBus`**: the typed publish/subscribe contract plugins use
  to receive sense data and publish alerts, instead of touching sensors
  directly.
- **`ModelRegistry`**: the contract plugins use to request on-demand
  model handles instead of loading models themselves.

`lumen-core` implements these contracts. `lumen-app` and every
`lumen-plugin-*` repository depend on this package, pinned to a tagged
release, never on `main`.

This package is pure Dart with no Flutter dependency, so plugin logic
that does not need widgets can be unit tested without the Flutter SDK.

## Installation

```yaml
dependencies:
  lumen_sdk: ^0.1.0
```

## Getting started

See [`example/example_plugin.dart`](example/example_plugin.dart) for a
complete, runnable plugin implementation, and
[`lib/lumen_sdk_testing.dart`](lib/lumen_sdk_testing.dart) for in-memory
fakes (`FakeEventBus`, `FakeModelRegistry`, `FakePluginContext`) used to
unit test a plugin without depending on `lumen-core`.

A minimal plugin looks like this:

```dart
import 'package:lumen_sdk/lumen_sdk.dart';

class MyPlugin implements LumenPlugin {
  @override
  final PluginManifest manifest = const PluginManifest(
    id: 'my-plugin',
    nameIt: 'Il mio modulo',
    nameEn: 'My module',
    version: '0.1.0',
    sdkConstraint: '^0.1.0',
    capabilities: [PluginCapability.microphone],
  );

  late PluginContext _context;

  @override
  Future<void> initialize(PluginContext context) async {
    _context = context;
  }

  @override
  Future<void> start() async {
    _context.eventBus.on<TranscriptEvent>().listen((event) {
      // React to transcripts here.
    });
  }

  @override
  Future<void> stop() async {
    // Cancel subscriptions and release model handles acquired in start.
  }

  @override
  Future<void> dispose() async {
    // Release resources acquired in initialize.
  }
}
```

## Development

```
dart pub get
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

Install the shared commit message hook before committing:

```
git config core.hooksPath .githooks
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

## Versioning

This package follows [Semantic Versioning](https://semver.org). A
breaking change to `LumenPlugin`, `LumenEventBus`, `ModelRegistry`, or
any type they expose is a major version bump, since every plugin
repository pins against a specific `lumen_sdk` version range.

## License

Apache License 2.0, see [LICENSE](LICENSE).
