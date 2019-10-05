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
import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

/// Represents a clock to display to the user.
class Clock {
  static const String TIMEZONE_KEY = "timezone";
  static const String LABEL_KEY = "label";

  int id;

  final TimeZone timeZone;
  final String label;

  /// Constructor requiring a [TimeZone] and a [String] as a label
  Clock({
    @required this.timeZone,
    @required this.label,
  });

  /// Get the [Duration] used to calculate the UTC offset for [TimeZone] set
  Duration get utcOffset {
    return timeZone.offset;
  }

  @override
  String toString() {
    return ('utcOffset: ${timeZone.offset}, label: $label,');
  }

  /// Return this object as a [Map<String, dynamic>] to be used for
  /// serialization and storage
  Map<String, dynamic> toMap() {
    return {
      TIMEZONE_KEY: timeZone.toMap(),
      LABEL_KEY: label,
    };
  }

  static Clock fromMap(Map<String, dynamic> map) {
    return Clock(
      timeZone: TimeZone.fromMap(map[TIMEZONE_KEY]),
      label: map[LABEL_KEY],
    );
  }
}