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