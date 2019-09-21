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

