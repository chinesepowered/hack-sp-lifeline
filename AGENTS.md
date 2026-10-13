# Lifeline: Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

## About the app

Lifeline is a daily voice check-in for older adults who live alone. A tablet in their home (the "companion") greets them by name in an ElevenLabs voice at the times their family picks, and they answer with a big button or by talking. Spoken answers are transcribed with ElevenLabs Scribe and triaged by rules. If nobody answers, Lifeline asks again and then alerts the whole care circle. Family members watch a live dashboard, acknowledge alerts ("I'm on it") and send messages that are spoken on the tablet. The judge-facing overview is in `README.md`.

Flutter routes (`lifeline_flutter/lib/app.dart`): `/` landing page, `/demo` (anonymous sign-in, then `createDemo`: Rose's tablet and Sam's dashboard side by side), `/family` (sign in, create or join a circle, dashboard), `/tablet` (pair with a 6-digit code).

Server code (`lifeline_server/lib/src/`):

- `models/`: tables `circle`, `circle_member`, `check_in_slot`, `check_in` (unique per circle and occurrence), `alert`, `circle_event` (activity feed), `utterance` (what the tablet says), `companion_device` (hashed token), `voice_clip`; DTOs `CircleSnapshot` and `CompanionState`; `LifelineException`.
- `circles/`: `CircleEndpoint` for family members (`requireLogin`, membership checks in `CircleAccess`), `CircleService`, `Snapshots`.
- `companion/`: `CompanionEndpoint` for the tablet, authenticated by device token, not by user.
- `checkins/`: `CheckInService` (start, respond, two-stage escalation, acknowledge), `Phrases` (every spoken line), `Schedules`, `LocalScheduler` and `Sweeper`, future calls.
- `voice/`: `VoiceService` caches each ElevenLabs clip once in public storage, served by `VoiceRoute` at `/voice/<sha256>.mp3`. It returns null without an API key, and the app then falls back to browser speech. The key is the password `elevenLabsApiKey` (`SERVERPOD_PASSWORD_elevenLabsApiKey` locally).
- `triage/`: `TriageEngine`, rule-based and unit-tested.
- `realtime/`: `CircleChannel`. Every state change must call `CircleChannel.notify`; the `watch()` streams then push a full snapshot.

Conventions:

- Schedule work only through `Schedules`. It uses future calls when `config.futureCall.enabled`, and otherwise `LocalScheduler` plus a once-a-minute `Sweeper` (Serverpod Cloud's Starter plan disables future calls). Keep every job idempotent, because both paths can run a job more than once.
- Escalation stage 1 runs after `graceSeconds` (missed alert, re-prompt) and stage 2 after `secondGraceSeconds` more (urgent "not responding" alert). Demo circles use 30 + 20 seconds and are deleted after 12 hours.
- The Flutter `LiveStream` reconnects streams with backoff and falls back to polling `circle.snapshot` / `companion.state` where WebSockets are blocked.

Deployment: Serverpod Cloud project `lifeline` (<https://lifeline.serverpod.space>). The pre-deploy hooks in `lifeline_server/scloud.yaml` run `serverpod generate` and build the Flutter web app into `lifeline_server/web/app`. Deploying is the user's decision.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `lifeline_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `lifeline_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.
