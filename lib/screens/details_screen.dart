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
        .of<ClocksProvider>(context)
        .clocks[clockIndex];
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
                ],
              ),
            ),
            bottomNavigationBar: ClockBottomAppBar(),
          );
        }
    );
  }
}
