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