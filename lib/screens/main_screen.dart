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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/components/bottom_app_bar.dart';
import 'package:world_clock/components/clock_list.dart';
import 'package:world_clock/providers/clocks_provider.dart';

import 'add_clock_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClocksProvider>(
      builder: (context, clocksProvider, child) =>
          Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: ClockList(
                showSeconds: clocksProvider.showSeconds,
                show24HourFormat: clocksProvider.show24HourFormat,
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(context: context,
                      builder: (BuildContext context) => AddClockBottomSheet());
                }),
            bottomNavigationBar: ClockBottomAppBar(),
          ),
    );
  }
}

