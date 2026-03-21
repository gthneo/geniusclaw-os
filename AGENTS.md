# GeniusClaw OS - Agent Guidelines

Hybrid project with **Node.js/P2P backend** and **Flutter/Dart mobile app**.

## Project Structure

```
src/           # Node.js backend (ESM modules): api/, core/, services/
lib/           # Flutter app: providers/, screens/, services/, models/
test/          # Flutter widget tests
```

---

## Build, Lint, and Test Commands

### Node.js Backend
```bash
npm install              # Install dependencies
npm run dev              # Run dev server (watch mode)
npm start                # Start production server
npm test                 # Run all tests
node --test src/core/p2p-network.test.js  # Run single test
npm run p2p              # Run P2P network only
npm run api              # Run API server only
npm run build:image      # Build Docker image
```

### Flutter/Dart App
```bash
flutter pub get          # Install dependencies
flutter run              # Run the app
flutter test             # Run all tests
flutter test test/widget_test.dart  # Run single test
flutter test --coverage  # Run with coverage
flutter analyze          # Lint/code analysis
flutter analyze --fix    # Auto-fix issues
flutter build apk        # Build for Android
flutter build ios        # Build for iOS

# Windows Desktop
flutter config --enable-windows-desktop  # Enable Windows desktop
flutter build windows --release            # Build Windows exe
# Output: build/windows/x64/release/bundle/geniusclaw_app.exe
```

---

## Code Style Guidelines

### JavaScript/Node.js
- ESM modules (`import`/`export`)
- JSDoc comments for classes/public methods; Chinese for complex logic
- 2 spaces indent, single quotes, semicolons
- Max line: 100 chars, use async/await
- Naming: `PascalCase` classes, `camelCase` functions, `UPPER_SNAKE_CASE` constants
- Files: `kebab-case.js`, imports include `.js` extension
- Error handling: try/catch for async, `console.error()`, throw descriptive errors
- Import order: built-in → external → relative

### Dart/Flutter
- Use Flutter official lints (`analysis_options.yaml`)
- **Riverpod required** for state management
- Material 3 design guidelines
- 2 spaces indent, `dart format`, trailing commas, `const` when possible
- Naming: `PascalCase` classes, `camelCase` methods, `_` prefix private, `snake_case.dart` files
- Constants: `kCamelCase` (not UPPER_SNAKE_CASE)
- Imports: `package:` for internal, order: dart: → package: → relative
- Error handling: try/catch with `AsyncValue` for async operations

---

## Key Patterns

### Node.js Service (extends EventEmitter)
- `constructor(config)`, `async start()`, `async stop()`, `isRunning()`, `getStatus()`

### Flutter Riverpod
- `FutureProvider` for async data, `StateNotifierProvider` for complex state
- `ref.invalidate()` to refresh, `AsyncValue` for loading/error states

---

## Testing

### JavaScript
- Node.js built-in test runner (`node --test`), test files: `*.test.js`

### Dart
- `flutter_test` package, `WidgetTester` for widget tests, mock external deps

---

## Configuration

**Node.js**: Create `.env` file with `MONGODB_URI`, `REDIS_URL`

**Flutter**: Edit `lib/config/api_config.dart` for API endpoints

---

## Code Examples

### JavaScript Service
```javascript
import EventEmitter from 'events';

class MyService extends EventEmitter {
  constructor(config = {}) {
    super();
    this.config = config;
    this.isRunning = false;
  }

  async start() {
    try {
      this.isRunning = true;
      console.log('Service started');
    } catch (error) {
      console.error('Failed to start:', error);
      throw error;
    }
  }

  async stop() {
    this.isRunning = false;
  }

  isRunning() {
    return this.isRunning;
  }
}
```

### Dart Riverpod Provider
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProvider = FutureProvider<MyModel>((ref) async {
  final service = ref.read(myServiceProvider);
  return await service.fetchData();
});

class MyController extends StateNotifier<AsyncValue<void>> {
  final MyService _service;

  MyController(this._service) : super(const AsyncValue.data(null));

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await _service.loadData();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
```

---

## Local LAN UI Requirements

This section documents the requirements for the local LAN user interface.

### Test Benchmark Address
- **Default IP**: `192.168.3.156`
- **Default Port**: `18790` (or `8080` for REST API)
- **WebSocket**: `ws://{host}:{port}/ws`

### Core Features
1. **Auto Discovery**: Scan local network for OpenClaw devices (mDNS/UDP broadcast)
2. **Manual Connection**: Allow user to input IP address and port
3. **Connection Status**: Display prominent status indicator (connected/connecting/disconnected)
4. **Address Persistence**: Save host configuration using `shared_preferences`
5. **IP Validation**: Validate IP format before connection attempt

### Error Handling
- Network unreachable: Show clear error with troubleshooting steps
- Service not running: Provide guidance to start OpenClaw service
- Connection timeout: Display timeout message with retry option

### Performance Targets
- Connection response: ≤200ms
- Command echo latency: ≤300ms
- Connection success rate: ≥99% (when network is healthy)

### Configuration Storage
Use `shared_preferences` to persist:
- `openclaw_host`: Last connected IP address
- `openclaw_port`: Last connected port
- `device_list`: Cached discovered devices

---

## Common Tasks

| Task | Command |
|------|---------|
| Add Node.js dep | `npm install <package>` |
| Add Flutter dep | `flutter pub add <package>` |
| Full analysis | `flutter analyze` |
| Format code | `flutter format lib/ src/` |
| Run backend | `npm run dev` |
| Run app | `flutter run` |
