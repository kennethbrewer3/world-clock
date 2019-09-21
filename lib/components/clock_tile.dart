import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/providers/clocks_provider.dart';

import 'reusable_card.dart';

class ClockTile extends StatelessWidget {
  final Clock clock;
  final Color backgroundColor;
  final Color timeColor;
  final Color dateColor;
  final Color labelColor;
  final Function tapFunction;

  static const clockTextSize = 30.0;
  static const labelTextSize = 30.0;

  ClockTile({this.clock,
    this.backgroundColor,
    this.timeColor,
    this.dateColor,
    this.labelColor,
    this.tapFunction});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClocksProvider>(
      builder: (context, clocksProvider, child) {
        return
          ReusableCard(
            tapFunction: tapFunction,
            color: backgroundColor,
            cardChild: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    clocksProvider.getTime(clock),
                    style: TextStyle(
                        fontSize: 50.0,
                        color: timeColor,
                        fontFamily: 'Ds-Digi'
                    ),
                  ),
                  Text(
                    clocksProvider.getDate(clock),
                    style: TextStyle(
                        fontSize: 50.0,
                        color: dateColor,
                        fontFamily: 'Ds-Digi'
                    ),
                  ),
                  Text(
                    clock.label,
                    style: TextStyle(
                      fontSize: ClockTile.labelTextSize,
                      color: labelColor,
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
