import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/providers/clocks_provider.dart';
import 'package:world_clock/timezoneloader/duration_parser.dart';

class AddClockProvider with ChangeNotifier {
  List<TimeZoneRegion> _timeZoneRegionList;
  String _newClockLabel = "";
  bool addButtonEnable = false;

  TimeZoneRegion timeZoneRegion;
  TimeZone timeZone;

  List<TimeZoneRegion> get timeZoneRegionList {
    return [..._timeZoneRegionList];
  }

  void updateClockLabel(String clockTitle) {
    _newClockLabel = clockTitle;
    if (_newClockLabel.isNotEmpty) {
      addButtonEnable = true;
    } else {
      addButtonEnable = false;
    }
    notifyListeners();
  }

  void addClockButtonListener(BuildContext context) {
    ClocksProvider provider = Provider.of<ClocksProvider>(context);
    Clock newClock = Clock(
      timeZone: timeZone,
      label: _newClockLabel,
    );

    if (provider.clocks.contains(newClock)) {
      return;
    }

    provider.addClock(newClock);
    Navigator.pop(context);
  }

  set timeZoneRegionList(List<TimeZoneRegion> value) {
    _timeZoneRegionList = value;
    timeZoneRegion = value[0];
    timeZone = value[0].timeZones[0];
  }

  UnmodifiableListView<
      DropdownMenuItem<TimeZoneRegion>> _mapTimeZoneRegionList() {
    return UnmodifiableListView<
        DropdownMenuItem<TimeZoneRegion>>(
        timeZoneRegionList.map<DropdownMenuItem<TimeZoneRegion>>((
            TimeZoneRegion timeZoneRegion) {
          return DropdownMenuItem<TimeZoneRegion>(
            value: timeZoneRegion,
            child: Text(
                timeZoneRegion.name,
                style: TextStyle(
                  fontSize: 24,
                ),
            ),
          );
        }
        ).toList());
  }

  UnmodifiableListView<
      DropdownMenuItem<TimeZoneRegion>> get timeZoneRegionDropDownMenuItemList {
    return _mapTimeZoneRegionList();
  }

  List<DropdownMenuItem<TimeZone>> get timeZoneList {
    return timeZoneRegion.timeZones
        .map<DropdownMenuItem<TimeZone>>((TimeZone timeZone) {
      return DropdownMenuItem<TimeZone>(
        value: timeZone,
        child: Text(
            "${DurationParser.formatDuration(timeZone.offset)} ${timeZone.name}",
            style: TextStyle(
              fontSize: 18,
            ),
        ),
      );
    }
    ).toList();
  }

  void updateTimeZoneRegionDropdown(TimeZoneRegion newTimeZoneRegion) {
    timeZoneRegion = newTimeZoneRegion;
    timeZone = timeZoneRegion.timeZones[0];
    notifyListeners();
  }

  void updateTimeZoneDropdown(TimeZone newTimeZone) {
    timeZone = newTimeZone;
    notifyListeners();
  }
}