# lumen_sdk

Italiano | [English](README.md)

L'SDK dei plugin per [Lumen](https://github.com/lumen-assistive), un
assistente open source, offline-first e rispettoso della privacy. Questo
pacchetto definisce i contratti da cui dipende ogni modulo di Lumen:

- **`LumenPlugin`**: il ciclo di vita implementato da ogni modulo
  (`initialize`, `start`, `stop`, `dispose`).
- **`LumenEventBus`**: il contratto tipizzato di pubblicazione e
  sottoscrizione che i plugin usano per ricevere i dati dei sensi e
  pubblicare avvisi, invece di accedere direttamente ai sensori.
- **`ModelRegistry`**: il contratto che i plugin usano per richiedere,
  su richiesta, un riferimento a un modello invece di caricarlo da soli.

`lumen-core` implementa questi contratti. `lumen-app` e ogni repository
`lumen-plugin-*` dipendono da questo pacchetto, ancorati a una versione
pubblicata, mai a `main`.

Questo pacchetto è Dart puro, senza dipendenza da Flutter: la logica dei
plugin che non richiede widget può essere testata senza l'SDK Flutter.

## Installazione

```yaml
dependencies:
  lumen_sdk: ^0.1.0
```

## Per iniziare

Vedi [`example/example_plugin.dart`](example/example_plugin.dart) per
un plugin completo e funzionante, e
[`lib/lumen_sdk_testing.dart`](lib/lumen_sdk_testing.dart) per i finti
oggetti in memoria (`FakeEventBus`, `FakeModelRegistry`,
`FakePluginContext`) usati per testare un plugin senza dipendere da
`lumen-core`.

## Sviluppo

```
dart pub get
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test
```

Installa l'hook condiviso per i messaggi di commit prima di fare commit:

```
git config core.hooksPath .githooks
```

Vedi [CONTRIBUTING.md](CONTRIBUTING.md) per il flusso di lavoro completo
(in inglese, come tutto il codice e la documentazione tecnica del
progetto).

## Versionamento

Questo pacchetto segue il [Versionamento Semantico](https://semver.org).
Una modifica incompatibile a `LumenPlugin`, `LumenEventBus`,
`ModelRegistry` o a un qualsiasi tipo da essi esposto comporta un
incremento della versione principale, poiché ogni repository di plugin
àncora una fascia di versione specifica di `lumen_sdk`.

## Licenza

Apache License 2.0, vedi [LICENSE](LICENSE).
