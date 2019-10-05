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
import 'package:world_clock/utils/duration_parser.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TimeZoneFileHandler', () {

    test('Parse empty string', () {
      String input = "";
      Duration expected = Duration();
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "+3"', () {
      String input = "+3";
      Duration expected = Duration(hours: 3);
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "+3:00"', () {
      String input = "+3:00";
      Duration expected = Duration(hours: 3);
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "+3:45"', () {
      String input = "+3:45";
      Duration expected = Duration(hours: 3, minutes: 45);
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "-3"', () {
      String input = "-3";
      Duration expected = Duration(hours: -3);
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "-3:00"', () {
      String input = "-3:00";
      Duration expected = Duration(hours: -3);
      expect(DurationParser.parse(input), expected);
    });

    test('Parse string of form "-3:45"', () {
      String input = "-3:45";
      Duration expected = Duration(hours: -3, minutes: -45);
      expect(DurationParser.parse(input), expected);
    });

    test('Return duration of zero if String is malformed', () {
      String input = "3:45";
      Duration expected = Duration();
      expect(DurationParser.parse(input), expected);
    });

    test('Test formatting of positive durations with whole hours', () {
      Duration input = Duration(hours: 3);
      String expected = "+3:00";
      expect(DurationParser.formatDuration(input), expected);
    });

    test('Test formatting of negative durations with whole hours', () {
      Duration input = Duration(hours: -3);
      String expected = "-3:00";
      expect(DurationParser.formatDuration(input), expected);
    });

    test('Test formatting of positive durations with hours and minutes', () {
      Duration input = Duration(hours: 3, minutes: 30);
      String expected = "+3:30";
      expect(DurationParser.formatDuration(input), expected);
    });

    test('Test formatting of negative durations with hours and minutes', () {
      Duration input = Duration(hours: -3, minutes: -30);
      String expected = "-3:30";
      expect(DurationParser.formatDuration(input), expected);
    });

    test('Test formatting of positive durations with hours and small minutes', () {
      Duration input = Duration(hours: 3, minutes: 5);
      String expected = "+3:05";
      expect(DurationParser.formatDuration(input), expected);
    });

    test('Test formatting of negative durations with hours and small minutes', () {
      Duration input = Duration(hours: -3, minutes: -5);
      String expected = "-3:05";
      expect(DurationParser.formatDuration(input), expected);
    });
  });
}