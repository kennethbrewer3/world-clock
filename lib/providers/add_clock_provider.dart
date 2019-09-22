import 'package:flutter/material.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';

class AddClockProvider with ChangeNotifier {
  List<TimeZoneRegion> _timeZoneRegionList = <TimeZoneRegion>[
    TimeZoneRegion.of('Africa', []),
    TimeZoneRegion.of('Antarctica', []),
    TimeZoneRegion.of('Asia', []),
    TimeZoneRegion.of('Atlantic', []),
    TimeZoneRegion.of('Australia', []),
    TimeZoneRegion.of('Caribbean', []),
    TimeZoneRegion.of('Central America', []),
    TimeZoneRegion.of('Europe', []),
    TimeZoneRegion.of('Indian Ocean', []),
    TimeZoneRegion.of('Military', []),
    TimeZoneRegion.of(
      "North America",
      [
        TimeZone(
          abbreviation: "GMT",
          name: "Greenwich Mean Time",
          offset: Duration(hours: 0),
        ),
        TimeZone(
          abbreviation: "EDT",
          name: "Eastern Daylight Time",
          offset: Duration(hours: -4),
        ),
        TimeZone(
          abbreviation: "CDT",
          name: "Central Daylight Time",
          offset: Duration(hours: -5),
        ),
        TimeZone(
          abbreviation: "PDT",
          name: "Pacific Daylight Time",
          offset: Duration(hours: -7),
        )
      ],
    ),
    TimeZoneRegion.of('Pacific', []),
    TimeZoneRegion.of('South America', []),
  ];

  TimeZoneRegion _timeZoneRegion;
  TimeZone _timeZone;

  AddClockProvider() {
    _timeZoneRegion = _timeZoneRegionList[0];
  }

  List<DropdownMenuItem<TimeZoneRegion>> get timeZoneRegionList {
    return _timeZoneRegionList
        .map<DropdownMenuItem<TimeZoneRegion>>((TimeZoneRegion timeZoneRegion) {
      return DropdownMenuItem<TimeZoneRegion>(
        value: timeZoneRegion,
        child: Text(timeZoneRegion.name),
      );
    }
    ).toList();
  }

  List<DropdownMenuItem<TimeZone>> get timeZoneList {
    return _timeZoneRegion.timeZones
        .map<DropdownMenuItem<TimeZone>>((TimeZone timeZone) {
      return DropdownMenuItem<TimeZone>(
        value: timeZone,
        child: Text("${_formatDuration(timeZone.offset)} ${timeZone.name}"),
      );
    }
    ).toList();
  }

  String _formatDuration(Duration duration) {
    Duration minutesDuration = duration - Duration(hours: duration.inHours);
    String sign = duration.isNegative ? "" : "+";
    String minutes = (minutesDuration.inMinutes < 10
        ? "0${minutesDuration.inMinutes}"
        : "${minutesDuration.inMinutes}");
    return "$sign${duration.inHours}:${minutes.replaceAll("-", "")}";
  }

  void updateTimeZoneRegionDropdown(TimeZoneRegion newTimeZoneRegion) {
    _timeZoneRegion = newTimeZoneRegion;
    notifyListeners();
  }

  void updateTimeZoneDropdown(TimeZone newTimeZone) {
    _timeZone = newTimeZone;
    notifyListeners();
  }

  TimeZoneRegion get timeZoneRegion {
    return _timeZoneRegion;
  }

  void setTimeZoneRegion(TimeZoneRegion newRegion) {
    _timeZoneRegion = newRegion;
  }

  TimeZone get timeZone {
    return _timeZone;
  }

  set timeZone(TimeZone timeZone) {
    this._timeZone = timeZone;
  }
}