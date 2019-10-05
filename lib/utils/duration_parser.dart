
class DurationParser {
  DurationParser._privateConstructor();

  static final DurationParser _instance = DurationParser._privateConstructor();

  static DurationParser get instance { return _instance;}

  static bool _isWellFormed(String input) {
    return input.startsWith("-") || input.startsWith("+");
  }

  static int _getSign(String input) {
    return (input.substring(0).startsWith("-")) ? -1 : 1;
  }

  static String _getUnsignedString(String input) {
    String output = input;
    if (input.startsWith("-") || input.startsWith("+")) {
      output = input.substring(1);
    }
    return output;
  }

  static List<int> _getHoursMinutes(String input) {
    int sign = _getSign(input);
    String unsignedString = _getUnsignedString(input);
    List<int> hoursMinutes = [0, 0];

    if (unsignedString.contains(":")) {
      List<String> tokens = unsignedString.split(":");
      hoursMinutes[0] = int.parse(tokens[0]) * sign;
      hoursMinutes[1] = int.parse(tokens[1]) * sign;
    } else {
      hoursMinutes[0] = int.parse(unsignedString) * sign;
      hoursMinutes[1] = 0;
    }

    return hoursMinutes;
  }

  static Duration parse(String input) {
    List<int> hoursMinutes = [0, 0];

    if (input.isNotEmpty && _isWellFormed(input)) {
      hoursMinutes = _getHoursMinutes(input);
    }

    return Duration(hours: hoursMinutes[0], minutes: hoursMinutes[1]);
  }

  static String formatDuration(Duration duration) {
    Duration minutesDuration = duration - Duration(hours: duration.inHours);
    String sign = duration.isNegative ? "" : "+";
    String minutes = (minutesDuration.inMinutes.abs() < 10
        ? "0${minutesDuration.inMinutes}"
        : "${minutesDuration.inMinutes}");
    return "$sign${duration.inHours}:${minutes.replaceAll("-", "")}";
  }
}