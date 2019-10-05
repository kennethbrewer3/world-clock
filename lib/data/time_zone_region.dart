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

import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

/// The time zones of the world are identified by region and then by name. This
/// represents a region within the world.
class TimeZoneRegion {
  String name;
  List<TimeZone> _timeZones;

  /// Instantiate with only a name. The [List<TimeZone>] will
  /// be instantiated to an empty list.
  TimeZoneRegion({@required this.name}) {
    _timeZones = List<TimeZone>();
  }

  /// Insantiate with a name as well as a populated [List<TimeZone>] to be
  /// included in the list.
  TimeZoneRegion.of(
      String name,
      List<TimeZone> timeZones
      ) {
    this.name = name;
    _timeZones = List<TimeZone>()
      ..addAll(timeZones);
  }

  /// Add a single [TimeZone] to the [List<TimeZone>]
  bool addTimeZone(TimeZone timeZone) {
    if (_timeZones.contains(timeZone)) {
      return false;
    } else {
      _timeZones.add(timeZone);
      return true;
    }
  }

  /// Return an UnodifiableListView<TimeZone> of the list of [TimeZone]s in this
  /// region.
  UnmodifiableListView<TimeZone> get timeZones {
    return UnmodifiableListView(_timeZones);
  }

  @override
  String toString() {
    return "$name: $timeZones";
  }

  @override
  bool operator == (Object timeZoneRegion) {
    return timeZoneRegion is TimeZoneRegion
        && this.name == timeZoneRegion.name
        && _timeZones == timeZoneRegion._timeZones;
  }

  @override
  int get hashCode {
    return this.name.hashCode + _timeZones.hashCode;
  }
}