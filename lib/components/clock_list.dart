import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/components/clock_tile.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/providers/clocks_provider.dart';

class ClockList extends StatelessWidget {
  final bool show24HourFormat;
  final bool showSeconds;

  ClockList({this.show24HourFormat, this.showSeconds});

  @override
  Widget build(BuildContext context) {
    return Consumer <List<Clock>>(
      builder: (context, clockList, child) {
        return ListView.builder(
          itemCount: clockList.length,
          itemBuilder: (context, clockIndex) {
            return ClockTile(
              tapFunction: () {
                Navigator.pushNamed(context, "/clocks/$clockIndex");
              },
              longPressFunction: () {
                Provider
                    .of<ClocksProvider>(context)
                    .removeClock(clockList[clockIndex]);
              },
              clock: clockList[clockIndex],
              backgroundColor: Theme
                  .of(context)
                  .backgroundColor,
              timeColor: Theme
                  .of(context)
                  .accentTextTheme
                  .title
                  .color,
              dateColor: Theme
                  .of(context)
                  .accentTextTheme
                  .title
                  .color,
              labelColor: Theme
                  .of(context)
                  .textTheme
                  .title
                  .color,
            );
          },
        );
      },
    );
  }
}
