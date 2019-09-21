import 'package:flutter/material.dart';

class AddClockProvider with ChangeNotifier {
  List<String> _timeZoneRegionList = <String>[
    'Africa',
    'Antarctica',
    'Asia',
    'Atlantic',
    'Australia',
    'Caribbean',
    'Central America',
    'Europe',
    'Indian Ocean',
    'Military',
    'North America',
    'Pacific',
    'South America',
  ];

  List<String> _timeZoneList = <String>[
    'One', 'Two', 'Free', 'Four'
  ];

  String _timeZoneRegion;
  String _timeZoneOffset;

  List<DropdownMenuItem<String>> get timeZoneRegionList {
    return _timeZoneRegionList
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }
    ).toList();
  }

  List<DropdownMenuItem<String>> get timeZoneList {
    return _timeZoneList
        .map<DropdownMenuItem<String>>((String value) {
      print("Current value: $value");
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }
    ).toList();
  }

  void updateTimeZoneRegionDropdown(String newRegion) {
    _timeZoneRegion = newRegion;
    notifyListeners();
  }

  void updateTimeZoneDropdown(String newValue) {
    _timeZoneOffset = newValue;
    notifyListeners();
  }

  String get timeZoneRegion {
    return _timeZoneRegion;
  }

  void setTimeZoneRegion(String newRegion) {
    _timeZoneRegion = newRegion;
  }

  String get timeZoneOffset {
    return _timeZoneOffset;
  }

  set timeZoneOffset(String newValue) {
    this._timeZoneOffset = newValue;
  }
}