/*
World Clock - Flutter app to display a list of clocks in different time zones.
Copyright (C) 2019  Kenneth B. Brewer III

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

kennethbrewer3@gmail.com
*/
import 'dart:async' show Future;
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/utils/duration_parser.dart';

/// Singleton that loads the json file and returns a list of [TimeZoneRegion]s.
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

  /// Does the actual parsing of the file in assets.
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