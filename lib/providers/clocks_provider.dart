import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_clock/data/clock.dart';
import 'dart:collection';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';

class ClocksProvider with ChangeNotifier {
  Timer timer;
  bool _show24HourFormat = false;
  bool _showSeconds = false;

  static final TimeZoneRegion northAmerica = TimeZoneRegion.of(
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
  );

  List<Clock> _clocks = [
    Clock(
      timeZone: northAmerica.timeZones[0],
      label: 'UTC',
    ),
    Clock(
      timeZone: northAmerica.timeZones[1],
      label: 'NYC',
    ),
    Clock(
      timeZone: northAmerica.timeZones[2],
      label: 'Dallas',
    ),
    Clock(
      timeZone: northAmerica.timeZones[3],
      label: 'Sacramento',
    )
  ];

  ClocksProvider() {
    _initializeTimer();
  }

  void _initializeTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
//      _baseTime = DateTime.now().toUtc();
      notifyListeners();
    });
  }

  DateTime _getNowPlusOffset(Clock clock) {
    return DateTime.now().toUtc().add(clock.utcOffset);
  }

  String getTime(Clock clock) {
    String hourType = (_show24HourFormat == true ? "kk" : "h");
    String seconds = (_showSeconds == true ? ":ss" : "");
    String hour24 = (_show24HourFormat == true ? "" : "a");
    String format = '$hourType:mm$seconds$hour24';
    return
        DateFormat(format).format(_getNowPlusOffset(clock));
  }

  String getDate(Clock clock) {
    return DateFormat('yyyy-MM-dd')
        .format(_getNowPlusOffset(clock));
  }

  set24HourFormat(bool show24HourFormat) {
    _show24HourFormat = show24HourFormat;
    notifyListeners();
  }

  void toggle24HourFormat() {
    set24HourFormat(!_show24HourFormat);
  }

  bool get show24HourFormat {
    return _show24HourFormat;
  }

  setShowSeconds(bool showSeconds) {
    _showSeconds = showSeconds;
    notifyListeners();
  }

  void toggleSeconds() {
    setShowSeconds(!_showSeconds);
  }

  bool get showSeconds {
    return _showSeconds;
  }

  UnmodifiableListView<Clock> get clocks {
    return UnmodifiableListView(_clocks);
  }

  bool addClock(Clock clock) {
    if (_clocks.contains(clock)) {
      return false;
    } else {
      _clocks.add(clock);
      notifyListeners();
      return true;
    }
  }

  bool removeClock(Clock clock) {
    if (_clocks.contains(clock)) {
      _clocks.remove(clock);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool moveClockToTop(Clock clock) {
    if (!_clocks.contains(clock)) {
      return false;
    } else {
      _clocks.remove(clock);
      _clocks.insert(0, clock);
      notifyListeners();
      return true;
    }
  }

  bool moveClockToBottom(Clock clock) {
    if (!_clocks.contains(clock)) {
      return false;
    } else {
      _clocks.remove(clock);
      _clocks.add(clock);
      return true;
    }
  }

  bool swapClockPositions(Clock clock1, Clock clock2) {
    if (!_clocks.contains(clock1) || !_clocks.contains(clock2)) {
      return false;
    } else {
      int position1 = _clocks.indexOf(clock1);
      int position2 = _clocks.indexOf(clock2);
      _clocks.remove(clock1);
      _clocks.remove(clock2);
      _clocks.insert(position2, clock1);
      _clocks.insert(position1, clock2);
      notifyListeners();
      return true;
    }
  }
}
