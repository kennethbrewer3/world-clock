import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/providers/clocks_provider.dart';

class ClockBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClocksProvider>(
      builder: (context, clocksProvider, child) {
      return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ToggleButtonsTheme(
            data: ToggleButtonsThemeData(
              fillColor: Theme.of(context).bottomAppBarColor,
              highlightColor: Theme.of(context).disabledColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ToggleButtons(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.globeAmericas)
                  ],
                  onPressed: (int index) {
                    clocksProvider.toggle24HourFormat();
                  },
                  isSelected: [clocksProvider.show24HourFormat],
                  disabledColor: Theme.of(context).disabledColor,
                  renderBorder: false,
                ),
                ToggleButtons(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.solidHourglass)
                  ],
                  onPressed: (int index) {
                    clocksProvider.toggleSeconds();
                  },
                  isSelected: [clocksProvider.showSeconds],
                  disabledColor: Theme.of(context).disabledColor,
                  renderBorder: false,
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}