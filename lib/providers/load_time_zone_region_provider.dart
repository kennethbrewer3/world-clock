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

import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/timezoneloader/timezone_file_handler.dart';

class LoadTimeZoneRegionProvider {

  List<TimeZoneRegion> timeZoneRegionList = List();

  Future<List<TimeZoneRegion>> loadTimeZoneRegionList() async {
    TimeZoneFileHandler handler = TimeZoneFileHandler();
    timeZoneRegionList = await handler.parseTimeZones();
    return timeZoneRegionList;
  }
}