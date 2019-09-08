import 'package:flutter/material.dart';
import 'package:world_clock/components/clock_tile.dart';
import 'package:world_clock/data/clock.dart';

class ClockList extends StatefulWidget {
  final List<Clock> clocks;
  final bool show24HourFormat;
  final bool showSeconds;

  ClockList({this.clocks, this.show24HourFormat, this.showSeconds});

  @override
  _ClockListState createState() => _ClockListState();
}

class _ClockListState extends State<ClockList>
    with AutomaticKeepAliveClientMixin<ClockList> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
        itemCount: widget.clocks.length,
        itemBuilder: (context, int) {
          return ClockTile(
            clock: widget.clocks[int],
            show24HourTime: widget.show24HourFormat,
            showSeconds: widget.showSeconds,
            backgroundColor: Theme.of(context).backgroundColor,
            timeColor: Theme.of(context).accentTextTheme.title.color,
            dateColor: Theme.of(context).accentTextTheme.title.color,
            cityColor: Theme.of(context).textTheme.title.color,
          );
        });
  }
}
