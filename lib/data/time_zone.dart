import 'package:meta/meta.dart';

class TimeZone {
  //Abbreviation	Time zone name	Location	Offset
  final String abbreviation;
  final String name;
  final String region;
  final double standardOffset;
  final double daylightSavingsTimeOffset;

  TimeZone({
    @required this.abbreviation,
    @required this.name,
    @required this.region,
    @required this.standardOffset,
    @required this.daylightSavingsTimeOffset
  });
}