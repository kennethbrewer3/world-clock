import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/timezoneloader/timezone_file_handler.dart';

class LoadTimeZoneRegionProvider {

  List<TimeZoneRegion> timeZoneRegionList = List();

  Future<List<TimeZoneRegion>> loadTimeZoneRegionList() async {
    TimeZoneFileHandler handler = TimeZoneFileHandler();
    timeZoneRegionList = await handler.parseTimeZones();
    return timeZoneRegionList;
  }
}