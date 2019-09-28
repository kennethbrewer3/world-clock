import 'package:meta/meta.dart';

class TimeZone {
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


}