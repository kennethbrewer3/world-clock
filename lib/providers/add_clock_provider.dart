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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/providers/clocks_provider.dart';
import 'package:world_clock/utils/duration_parser.dart';

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

  void addClockButtonListener(BuildContext context) async {
    ClocksProvider provider = Provider.of<ClocksProvider>(context);
    Clock newClock = Clock(
      timeZone: timeZone,
      label: _newClockLabel,
    );

    List<Clock> clocks = await provider.clocks;

    if (clocks.contains(newClock)) {
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