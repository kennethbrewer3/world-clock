import 'package:meta/meta.dart';
import 'package:world_clock/data/time_zone.dart';

class Clock {
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


}