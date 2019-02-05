import 'package:logging/logging.dart';

final Logger log = new Logger('CATALOG')
  ..onRecord.listen((LogRecord rec) {
    print('LOG ${rec.level.name}: ${rec.message}');
  });

void logObject(String msg, Object o) {
  log.info(msg);
  for (String line in o.toString().split('\n')) {
    log.info('-- $line');
  }
}

void logMessage(String msg) {
  log.info(msg);
}

void logException(String source, String message) {
  log.warning('Exception ($source): $message');
}
