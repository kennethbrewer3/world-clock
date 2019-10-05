import 'package:meta/meta.dart';
import 'package:world_clock/utils/duration_parser.dart';

class TimeZone {
  static const String ABBREVIATION_KEY = "abbreviation";
  static const String NAME_KEY = "name";
  static const String OFFSET_KEY = "offset";

  final String abbreviation;
  final String name;
  final Duration offset;

  TimeZone({
    @required this.abbreviation,
    @required this.name,
    @required this.offset,
  });

  @override
  String toString() {
    return "abbreviation: $abbreviation, name: $name, offset: $offset";
  }

  @override
  bool operator ==(other) {
    return other is TimeZone
    && abbreviation == other.abbreviation
    && name == other.name
    && offset == other.offset;
  }


  @override
  int get hashCode {
    return abbreviation.hashCode + name.hashCode + offset.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      ABBREVIATION_KEY: abbreviation,
      NAME_KEY: name,
      OFFSET_KEY: DurationParser.formatDuration(offset),
    };
  }

  static TimeZone fromMap(Map<String, dynamic> map) {
    return TimeZone(
      abbreviation: map[ABBREVIATION_KEY],
      name: map[NAME_KEY],
      offset: map[OFFSET_KEY] is Duration ? map[OFFSET_KEY] : DurationParser.parse(map[OFFSET_KEY]),
    );
  }
}