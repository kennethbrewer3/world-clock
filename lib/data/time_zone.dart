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
import 'package:world_clock/utils/duration_parser.dart';

/// Represents a time zone of the world.
class TimeZone {
  static const String ABBREVIATION_KEY = "abbreviation";
  static const String NAME_KEY = "name";
  static const String OFFSET_KEY = "offset";

  final String abbreviation;
  final String name;
  final Duration offset;

  /// Constructor that takes a [String] abbreviation, a [String] name,
  /// and a [Duration] as an offset of UTC time.
  TimeZone({
    @required this.abbreviation,
    @required this.name,
    @required this.offset,
  });

  @override
  String toString() {
    return "abbreviation: $abbreviation, name: $name, offset: $offset";
  }

  @override
  bool operator ==(other) {
    return other is TimeZone
    && abbreviation == other.abbreviation
    && name == other.name
    && offset == other.offset;
  }


  @override
  int get hashCode {
    return abbreviation.hashCode + name.hashCode + offset.hashCode;
  }

  /// Returns a [Map<String, dynamic>] used to serialize and store this object
  Map<String, dynamic> toMap() {
    return {
      ABBREVIATION_KEY: abbreviation,
      NAME_KEY: name,
      OFFSET_KEY: DurationParser.formatDuration(offset),
    };
  }

  /// Takes a [Map<String, dynamic>] that must include a [String] for the
  /// abbreviation, a [String] for the name, and either a
  /// [Duration] to act as the offset or a [String] that will be parsed to
  /// become the offset
  static TimeZone fromMap(Map<String, dynamic> map) {
    return TimeZone(
      abbreviation: map[ABBREVIATION_KEY],
      name: map[NAME_KEY],
      offset: map[OFFSET_KEY] is Duration
          ? map[OFFSET_KEY]
          : DurationParser.parse(map[OFFSET_KEY]),
    );
  }
}