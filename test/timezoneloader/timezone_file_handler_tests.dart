import 'package:flutter_test/flutter_test.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/timezoneloader/timezone_file_handler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TimeZoneFileHandler', () {

    test('value should be incremented', () async {
      TimeZoneFileHandler handler = TimeZoneFileHandler();
      List<TimeZoneRegion> list = await handler.parseTimeZones();


    });

//    test('value should be decremented', () {
//      final counter = Counter();
//
//      counter.decrement();
//
//      expect(counter.value, -1);
//    });
  });
}