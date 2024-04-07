import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

extension ClassLogger on Object {
  Logger get logger => Logger(runtimeType.toString());
}

class LogManager {
  static initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print("${record.level.name}: ${record.time} ${record.loggerName} | ${record.message}");
      } else {
        // No printing in release versions :)
      }
    });
  }
}
