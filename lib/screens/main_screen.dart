import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/components/clock_list.dart';
import 'package:world_clock/components/toggle_button.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/data/clock_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _baseTime = DateTime.now().toUtc();

  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _baseTime = DateTime.now().toUtc();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockModel>(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: ClockList(
              clocks: model.getClocks(),
              showSeconds: model.showSeconds(),
              show24HourFormat: model.show24HourFormat(),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              model.addClock(Clock(utcOffset: 3, label: 'New Clock'));
            },
          ),
          bottomNavigationBar: buildBottomAppBar(context, model)),
    );
  }

  Widget buildBottomAppBar(BuildContext context, ClockModel model) {
    Color toggleOnColor = Theme.of(context).accentColor;
    Color toggleOffColor = Theme.of(context).disabledColor;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ToggleButton(
              onIcon: FontAwesomeIcons.globeAmericas,
              offIcon: FontAwesomeIcons.globeAmericas,
              onColor: toggleOnColor,
              offColor: toggleOffColor,
              onAction: () {
                model.set24HourFormat(true);
              },
              offAction: () {
                model.set24HourFormat(false);
              },
            ),
            ToggleButton(
              onIcon: FontAwesomeIcons.solidHourglass,
              offIcon: FontAwesomeIcons.solidHourglass,
              onColor: toggleOnColor,
              offColor: toggleOffColor,
              onAction: () {
                model.setShowSeconds(true);
              },
              offAction: () {
                model.setShowSeconds(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
