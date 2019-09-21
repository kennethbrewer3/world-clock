import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

class Clock {
  final TimeZone timeZone;
  final bool daylightSavingsTime;
  final String label;

  Clock({
    @required this.timeZone,
    @required this.daylightSavingsTime,
    @required this.label,
  });

  double get utcOffset {
    double utcOffset;
    if (daylightSavingsTime == true) {
      utcOffset = timeZone.daylightSavingsTimeOffset;
    } else {
      utcOffset = timeZone.standardOffset;
    }
    return utcOffset;
  }

  @override
  String toString() {
    double utcOffset;
    if (daylightSavingsTime == true) {
      utcOffset = timeZone.daylightSavingsTimeOffset;
    } else {
      utcOffset = timeZone.standardOffset;
    }
    return ('utcOffset: $utcOffset, label: $label,');
  }


}