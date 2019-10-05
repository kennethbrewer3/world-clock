import 'dart:async' show Future;
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/utils/duration_parser.dart';

class TimeZoneFileHandler {
  final String _timeZoneFileName = "assets/timezones.json";

  List<TimeZoneRegion> _timeZoneRegions;

  static const String _ROOT = "locations";
  static const String _TIMEZONES = "timezones";
  static const String _ABBREVIATION = "abbreviation";
  static const String _NAME = "name";
  static const String _OFFSET = "offset";

  TimeZoneFileHandler() {
    _timeZoneRegions = List<TimeZoneRegion>();
  }

  Future<String> _loadAsset() async {
    return await rootBundle.loadString(_timeZoneFileName);
  }

  Future<UnmodifiableListView<TimeZoneRegion>> parseTimeZones() async {
    Map decoded = jsonDecode(await _loadAsset());

    if (decoded.containsKey(_ROOT)) {
      List regions = decoded[_ROOT];
      for (var region in regions) {
        List timeZonesDecoded = region[_TIMEZONES];
        List<TimeZone> timeZones = List();

        for (var zone in timeZonesDecoded) {
          String abbreviation = zone[_ABBREVIATION];
          String name = zone[_NAME];
          Duration offset = DurationParser.parse(zone[_OFFSET]);
          timeZones.add(
              TimeZone(
                  abbreviation: abbreviation,
                  name: name,
                  offset: offset)
          );
        }

        String name = region[_NAME];
        _timeZoneRegions.add(TimeZoneRegion.of(
          name,
          timeZones,
        ));
      }
    }

    return UnmodifiableListView(_timeZoneRegions);
  }


}