import 'dart:developer' as developer;

class Logger {
  static void log(String message, {int level = 0}) {
    developer.log(message, level: level);
  }

  static void info(String message) {
    log(message, level: Level.INFO);
  }

  static void warning(String message) {
    log(message, level: Level.WARNING);
  }

  static void error(String message) {
    log(message, level: Level.SEVERE);
  }

  static void logBuildMethodCalled(Object runtimeType){
    log('$runtimeType build method is called');
  }
  static void logInitMethodCalled(Object runtimeType){
    log('$runtimeType init method is called');
  }
}

class Level {
  static const int INFO = 800;
  static const int WARNING = 900;
  static const int SEVERE = 1000;
}
