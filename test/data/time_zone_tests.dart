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

import 'package:flutter_test/flutter_test.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/utils/duration_parser.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TimeZoneTests', () {

    test('Create a map from a TimeZone with positive offset', () {
      String abbreviation = "test";
      String name = "test time zone";
      Duration offset = Duration(hours: 3, minutes: 45);

      TimeZone testTimeZone = TimeZone(
        abbreviation: abbreviation,
        name: name,
        offset: offset,
      );

      Map<String, dynamic> map = testTimeZone.toMap();

      expect(map[TimeZone.ABBREVIATION_KEY], abbreviation);
      expect(map[TimeZone.NAME_KEY], name);
      expect(map[TimeZone.OFFSET_KEY], DurationParser.formatDuration(offset));
    });

    test('Create a map from a TimeZone with negative offset', () {
      String abbreviation = "test";
      String name = "test time zone";
      Duration offset = Duration(hours: -3, minutes: -45);

      TimeZone testTimeZone = TimeZone(
        abbreviation: abbreviation,
        name: name,
        offset: offset,
      );

      Map<String, dynamic> map = testTimeZone.toMap();

      expect(map[TimeZone.ABBREVIATION_KEY], abbreviation);
      expect(map[TimeZone.NAME_KEY], name);
      expect(map[TimeZone.OFFSET_KEY], DurationParser.formatDuration(offset));
    });

    test('Create a timezone from a map with positive offset', () {
      Duration offsetDuration = Duration(hours: 3, minutes: 45);
      String abbreviation = "test";
      String name = "test time zone";
      String offsetString = "+3:45";

      Map<String, dynamic> map = {
        "abbreviation": abbreviation,
        "name": name,
        "offset": offsetString,
      };

      TimeZone testTimeZone = TimeZone.fromMap(map);

      expect(abbreviation, testTimeZone.abbreviation);
      expect(name, testTimeZone.name);
      expect(offsetDuration, testTimeZone.offset);
    });

    test('Create a timezone from a map with negative offset', () {
      Duration offsetDuration = Duration(hours: -3, minutes: -45);
      String abbreviation = "test";
      String name = "test time zone";
      String offsetString = "-3:45";

      Map<String, dynamic> map = {
        "abbreviation": abbreviation,
        "name": name,
        "offset": offsetString,
      };

      TimeZone testTimeZone = TimeZone.fromMap(map);

      expect(abbreviation, testTimeZone.abbreviation);
      expect(name, testTimeZone.name);
      expect(offsetDuration, testTimeZone.offset);
    });

    test('Test equals method', () {
      TimeZone testTimeZone1 = TimeZone(
        abbreviation: "U",
        name: "Uniform Time Zone",
        offset: Duration(hours: -8),
      );

      TimeZone testTimeZone2 = TimeZone(
        abbreviation: "U",
        name: "Uniform Time Zone",
        offset: Duration(hours: -8),
      );

      TimeZone testTimeZone3 = TimeZone(
        abbreviation: "F",
        name: "Foxtrot Time Zone",
        offset: Duration(hours: 6),
      );

      expect(testTimeZone1, testTimeZone2);
      expect(testTimeZone1, isNot(testTimeZone3));
    });

    test('Test hashcode method', () {
      TimeZone testTimeZone1 = TimeZone(
        abbreviation: "U",
        name: "Uniform Time Zone",
        offset: Duration(hours: -8),
      );

      TimeZone testTimeZone2 = TimeZone(
        abbreviation: "U",
        name: "Uniform Time Zone",
        offset: Duration(hours: -8),
      );

      TimeZone testTimeZone3 = TimeZone(
        abbreviation: "F",
        name: "Foxtrot Time Zone",
        offset: Duration(hours: 6),
      );

      expect(testTimeZone1.hashCode, testTimeZone2.hashCode);
      expect(testTimeZone1.hashCode, isNot(testTimeZone3.hashCode));
    });
  });
}