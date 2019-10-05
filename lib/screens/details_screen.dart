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
import 'package:world_clock/components/clock_tile.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/providers/clocks_provider.dart';

class ClockDetails extends StatelessWidget {
  final String title;
  final String detailsPath;

  ClockDetails({this.title, this.detailsPath});

  Clock _getClockFromPath(BuildContext context) {
    int clockIndex = int.parse(detailsPath
        .split("/")
        .last);
    return Provider
        .of<List<Clock>>(context)[clockIndex];
  }

  @override
  Widget build(BuildContext context) {
    final Clock clock = _getClockFromPath(context);
    return Consumer<ClocksProvider>(
        builder: (context, clocksProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("$title - ${clock.label}"),
            ),
            backgroundColor: Theme
                .of(context)
                .backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    clocksProvider.getTime(clock),
                    style: TextStyle(
                        fontSize: 100.0,
                        color: Theme
                            .of(context)
                            .accentTextTheme
                            .title
                            .color,
                        fontFamily: 'Ds-Digi'
                    ),
                  ),
                  Text(
                    clocksProvider.getDate(clock),
                    style: TextStyle(
                        fontSize: 90.0,
                        color: Theme
                            .of(context)
                            .accentTextTheme
                            .title
                            .color,
                        fontFamily: 'Ds-Digi'
                    ),
                  ),
                  Text(
                    clock.label,
                    style: TextStyle(
                      fontSize: ClockTile.labelTextSize,
                      color: Theme
                          .of(context)
                          .textTheme
                          .title
                          .color,
                    ),
                  ),
                  Text(
                    clock.timeZone.name,
                    style: TextStyle(
                      fontSize: ClockTile.timeZoneLabelTextSize,
                      color: Theme
                          .of(context)
                          .textTheme
                          .title
                          .color,
                    ),
                    ),
                ],
              ),
            ),
            bottomNavigationBar: ClockBottomAppBar(),
          );
        }
    );
  }
}
