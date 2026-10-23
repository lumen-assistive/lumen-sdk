# Contributing to lumen_sdk

This repository defines the contracts every Lumen module depends on,
so a breaking change here affects every plugin and the app itself.
Open an issue to discuss any change to `LumenPlugin`, `LumenEventBus`,
`ModelRegistry`, or any type they expose, before sending a pull
request.

See the organization-wide
[CONTRIBUTING.md](https://github.com/lumen-assistive/.github/blob/main/CONTRIBUTING.md)
for the general workflow. This file only covers what is specific to
this repository.

## Setup

This is a pure Dart package; the Flutter SDK is not required.

```
dart pub get
git config core.hooksPath .githooks
```

## Before sending a pull request

```
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

All three must pass; CI runs the same commands on every push and pull
request.

## Adding a new event or contract type

- Add the type under `lib/src/`, export it from `lib/lumen_sdk.dart`,
  and add a corresponding entry to `CHANGELOG.md` under `[Unreleased]`.
- Add a unit test under `test/`.
- If the change is additive (a new event type, a new optional field),
  it is a minor version bump. If it changes or removes an existing
  public member, it is a major version bump: call this out explicitly
  in the pull request description.

## Adding a fake to `lumen_sdk_testing`

Fakes under `lib/src/testing/` must stay simple, in-memory, and free of
timers or real I/O, so that plugin unit tests relying on them stay fast
and deterministic.
