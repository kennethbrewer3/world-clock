import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_clock/data/clock.dart';
import 'dart:collection';
import 'package:world_clock/data/time_zone.dart';

class ClocksProvider with ChangeNotifier {
//  DateTime _baseTime = DateTime.now().toUtc();
  Timer timer;
  bool _show24HourFormat = false;
  bool _showSeconds = false;

  static final TimeZone utc = TimeZone(
      abbreviation: "GMT",
      name: "Greenwich Mean Time",
      region: "Europe Africa North America Antarctica",
      standardOffset: 0.0,
      daylightSavingsTimeOffset: 0.0
  );

  static final TimeZone edt = TimeZone(
      abbreviation: "EDT",
      name: "Eastern Daylight Time",
      region: "North America",
      standardOffset: -4.0,
      daylightSavingsTimeOffset: -4.0
  );

  static final TimeZone cdt = TimeZone(
      abbreviation: "CDT",
      name: "Central Daylight Time",
      region: "North America",
      standardOffset: -5.0,
      daylightSavingsTimeOffset: -5.0
  );

  static final TimeZone pdt = TimeZone(
      abbreviation: "PDT",
      name: "Pacific Daylight Time",
      region: "North America",
      standardOffset: -7.0,
      daylightSavingsTimeOffset: -7.0
  );

  List<Clock> _clocks = [
    Clock(
      timeZone: utc,
      label: 'UTC',
    ),
    Clock(
      timeZone: edt,
      label: 'NYC',
    ),
    Clock(
      timeZone: cdt,
      label: 'Dallas',
    ),
    Clock(
      timeZone: pdt,
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
    int utcHours = 0;

    if (clock.utcOffset < 0) {
      utcHours = clock.utcOffset.ceil();
    } else {
      utcHours = clock.utcOffset.floor();
    }

    int utcMinutes = (60 * (clock.utcOffset - utcHours)).toInt();

    return DateTime
        .now()
        .toUtc()
        .add(
          Duration(hours: utcHours)
        )
        .add(
          Duration(minutes: utcMinutes)
        );
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
    }
  }
}
