import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

class TimeZoneRegion {
  String name;
  List<TimeZone> _timeZones;

  TimeZoneRegion({@required this.name}) {
    _timeZones = List<TimeZone>();
  }

  TimeZoneRegion.of(
      String name,
      List<TimeZone> timeZones
      ) {
    this.name = name;
    _timeZones = List<TimeZone>()
      ..addAll(timeZones);
  }

  bool addTimeZone(TimeZone timeZone) {
    if (_timeZones.contains(timeZone)) {
      return false;
    } else {
      _timeZones.add(timeZone);
      return true;
    }
  }

  UnmodifiableListView<TimeZone> get timeZones {
    return UnmodifiableListView(_timeZones);
  }
}