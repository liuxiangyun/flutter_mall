import 'package:event_bus/event_bus.dart';

class FlutterEventBus {
  factory FlutterEventBus() => _getInstance();

  static FlutterEventBus _instance;

  static FlutterEventBus get instance => _getInstance();

  final EventBus eventBus = new EventBus();

  FlutterEventBus._internal();

  static FlutterEventBus _getInstance() {
    if (_instance == null) {
      _instance = FlutterEventBus._internal();
    }
    return _instance;
  }
}
