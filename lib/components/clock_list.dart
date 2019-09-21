import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/components/clock_tile.dart';
import 'package:world_clock/providers/clocks_provider.dart';

class ClockList extends StatelessWidget {
  final bool show24HourFormat;
  final bool showSeconds;

  ClockList({this.show24HourFormat, this.showSeconds});

  @override
  Widget build(BuildContext context) {
    return Consumer <ClocksProvider>(
      builder: (context, clocksProvider, child) {
        return ListView.builder(
          itemCount: clocksProvider.clocks.length,
          itemBuilder: (context, clockIndex) {
            return ClockTile(
              tapFunction: () {
                Navigator.pushNamed(context, "/clocks/$clockIndex");
              },
              clock: clocksProvider.clocks[clockIndex],
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
