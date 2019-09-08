import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_clock/data/clock.dart';

import 'reusable_card.dart';

class ClockTile extends StatefulWidget {
  final Clock clock;
  final bool show24HourTime;
  final bool showSeconds;
  final Color backgroundColor;
  final Color timeColor;
  final Color dateColor;
  final Color cityColor;

  static const clockTextSize = 30.0;
  static const labelTextSize = 30.0;

  ClockTile(
      {this.clock,
      this.show24HourTime,
      this.showSeconds,
      this.backgroundColor,
      this.timeColor,
      this.dateColor,
      this.cityColor});

  @override
  _ClockTileState createState() => _ClockTileState();
}

class _ClockTileState extends State<ClockTile>
    with AutomaticKeepAliveClientMixin<ClockTile> {
  @override
  bool get wantKeepAlive => true;

  String _time = "";
  String _date = "";

  DateTime _getNowPlusOffset(int offset) {
    return DateTime.now().toUtc().add(Duration(hours: widget.clock.utcOffset));
  }

  void setTime() {
    String hourType = (widget.show24HourTime == true ? "kk" : "h");
    String seconds = (widget.showSeconds == true ? ":ss" : "");
    String hour24 = (widget.show24HourTime == true ? "" : "a");
    String format = '$hourType:mm$seconds$hour24';
    _time =
        DateFormat(format).format(_getNowPlusOffset(widget.clock.utcOffset));
  }

  void setDate() {
    _date = DateFormat('yyyy-MM-dd')
        .format(_getNowPlusOffset(widget.clock.utcOffset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    setTime();
    setDate();

    return ReusableCard(
      color: widget.backgroundColor,
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
              _time,
              style: TextStyle(
                fontSize: 50.0,
                color: widget.timeColor,
              ),
            ),
            Text(
              _date,
              style: TextStyle(
                fontSize: 50.0,
                color: widget.dateColor,
              ),
            ),
            Text(
              widget.clock.label,
              style: TextStyle(
                fontSize: ClockTile.labelTextSize,
                color: widget.cityColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
