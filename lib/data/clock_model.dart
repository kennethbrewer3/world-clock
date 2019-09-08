import 'package:flutter/material.dart';
import 'package:world_clock/data/clock.dart';

class ClockModel with ChangeNotifier {
  bool _show24HourFormat = false;
  bool _showSeconds = false;

  static List<Clock> _clocks = [
    Clock(
      utcOffset: 0,
      label: 'UTC',
    ),
    Clock(
      utcOffset: -4,
      label: 'NYC',
    ),
    Clock(
      utcOffset: -5,
      label: 'Dallas',
    ),
    Clock(
      utcOffset: -7,
      label: 'Sacramento',
    )
  ];

  set24HourFormat(bool show24HourFormat) {
    _show24HourFormat = show24HourFormat;
  }

  bool show24HourFormat() {
    return _show24HourFormat;
  }

  setShowSeconds(bool showSeconds) {
    _showSeconds = showSeconds;
  }

  bool showSeconds() {
    return _showSeconds;
  }

  List<Clock> getClocks() {
    return _clocks;
  }

  bool addClock(Clock clock) {
    if (_clocks.contains(clock)) {
      return false;
    } else {
      _clocks.add(clock);
      return true;
    }
  }

  bool removeClock(Clock clock) {
    if (_clocks.contains(clock)) {
      _clocks.remove(clock);
      return true;
    } else {
      return false;
    }
  }
}
