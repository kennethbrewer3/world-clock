import 'package:flutter_test/flutter_test.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/data/time_zone.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ClockTests', () {

    String label = "Sky Net Central Core";
    TimeZone uniformTimeZone = TimeZone (
      abbreviation: "U",
      name: "Uniform",
      offset: Duration(hours: -8),
    );

    test('Create a map from a Clock with positive offset', () {

      Clock testClock = Clock(
        label: label,
        timeZone: uniformTimeZone,
      );

      Map<String, dynamic> map = testClock.toMap();

      expect(map[Clock.LABEL_KEY], label);
      expect(map[Clock.TIMEZONE_KEY], uniformTimeZone.toMap());
    });

    test('Create a Clock from a map', () {

      Map<String, dynamic> map = {
        Clock.LABEL_KEY: label,
        Clock.TIMEZONE_KEY: uniformTimeZone.toMap(),
      };

      Clock testClock = Clock.fromMap(map);

      expect(label, testClock.label);
      expect(uniformTimeZone, testClock.timeZone);
    });
  });
}