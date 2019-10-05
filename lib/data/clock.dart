import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

class Clock {
  static const String TIMEZONE_KEY = "timezone";
  static const String LABEL_KEY = "label";

  int id;

  final TimeZone timeZone;
  final String label;

  Clock({
    @required this.timeZone,
    @required this.label,
  });

  Duration get utcOffset {
    return timeZone.offset;
  }

  @override
  String toString() {
    return ('utcOffset: ${timeZone.offset}, label: $label,');
  }

  Map<String, dynamic> toMap() {
    return {
      TIMEZONE_KEY: timeZone.toMap(),
      LABEL_KEY: label,
    };
  }

  static Clock fromMap(Map<String, dynamic> map) {
    return Clock(
      timeZone: TimeZone.fromMap(map[TIMEZONE_KEY]),
      label: map[LABEL_KEY],
    );
  }
}