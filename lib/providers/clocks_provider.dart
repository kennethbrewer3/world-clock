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
