import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/database/clock_dao.dart';

class ClocksProvider with ChangeNotifier {
  Timer timer;
  bool _show24HourFormat = false;
  bool _showSeconds = false;

  ClockDao _clockDao;
  List<Clock> clocks;

  ClocksProvider() {
    _initializeTimer();
    _clockDao = ClockDao();
  }

  void _initializeTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
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

  bool addClock(Clock clock) {
    if (clocks.contains(clock)) {
      return false;
    } else {
      clocks.add(clock);
      _clockDao.insert(clock);
      notifyListeners();
      return true;
    }
  }

  bool removeClock(Clock clock) {
    if (clocks.contains(clock)) {
      clocks.remove(clock);
      _clockDao.delete(clock);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool moveClockToTop(Clock clock) {
    if (!clocks.contains(clock)) {
      return false;
    } else {
      clocks.remove(clock);
      clocks.insert(0, clock);
      notifyListeners();
      return true;
    }
  }

  bool moveClockToBottom(Clock clock) {
    if (!clocks.contains(clock)) {
      return false;
    } else {
      clocks.remove(clock);
      clocks.add(clock);
      return true;
    }
  }

  bool swapClockPositions(Clock clock1, Clock clock2) {
    if (!clocks.contains(clock1) || !clocks.contains(clock2)) {
      return false;
    } else {
      int position1 = clocks.indexOf(clock1);
      int position2 = clocks.indexOf(clock2);
      clocks.remove(clock1);
      clocks.remove(clock2);
      clocks.insert(position2, clock1);
      clocks.insert(position1, clock2);
      notifyListeners();
      return true;
    }
  }
}
