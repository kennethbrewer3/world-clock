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

/// Handles parsing and formatting of [Durations].
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

  /// Accepts a [String] of the format "+HH:mm" or "-MM:mm" and provides a
  /// [Duration] with those values set
  static Duration parse(String input) {
    List<int> hoursMinutes = [0, 0];

    if (input.isNotEmpty && _isWellFormed(input)) {
      hoursMinutes = _getHoursMinutes(input);
    }

    return Duration(hours: hoursMinutes[0], minutes: hoursMinutes[1]);
  }

  /// Accepts a [Duration] and provides a [String] of the format "+HH:mm" if
  /// positive or "-HH:mm" if both hours and minutes are negative. Note that
  /// any other property of [Duration] will be ignored if set.
  static String formatDuration(Duration duration) {
    Duration minutesDuration = duration - Duration(hours: duration.inHours);
    String sign = duration.isNegative ? "" : "+";
    String minutes = (minutesDuration.inMinutes.abs() < 10
        ? "0${minutesDuration.inMinutes}"
        : "${minutesDuration.inMinutes}");
    return "$sign${duration.inHours}:${minutes.replaceAll("-", "")}";
  }
}