import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/time_zone.dart';
import 'package:world_clock/data/time_zone_region.dart';
import 'package:world_clock/providers/add_clock_provider.dart';
import 'package:world_clock/providers/load_time_zone_region_provider.dart';

class AddClockBottomSheet extends StatelessWidget {
  final LoadTimeZoneRegionProvider _loadTimeZoneRegionProvider =
      LoadTimeZoneRegionProvider();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<TimeZoneRegion>>.value(
      initialData: _loadTimeZoneRegionProvider.timeZoneRegionList,
      value: _loadTimeZoneRegionProvider.loadTimeZoneRegionList(),
      child: Consumer<List<TimeZoneRegion>>(
          builder: (context, timeZoneRegionList, child) {
        return ChangeNotifierProxyProvider<List<TimeZoneRegion>,
            AddClockProvider>(
          initialBuilder: (_) => AddClockProvider(),
          builder: (_, timeZoneRegionList, futureNotifier) =>
              futureNotifier..timeZoneRegionList = timeZoneRegionList,
          child: Consumer<AddClockProvider>(
            builder: (context, addClockProvider, child) {
              return Container(
                padding: EdgeInsets.all(20.0),
                height: 500,
                child: timeZoneRegionList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Add Clock",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Theme.of(context).appBarTheme.color),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Clock label",
                            ),
                            textAlign: TextAlign.center,
                            autofocus: true,
                            onChanged: (clockTitle) =>
                                addClockProvider.updateClockLabel(clockTitle),
                          ),
                          DropdownButton<TimeZoneRegion>(
                            value: addClockProvider.timeZoneRegion,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            underline: Container(
                              height: 2,
                              color: Theme.of(context).appBarTheme.color,
                            ),
                            onChanged:
                                addClockProvider.updateTimeZoneRegionDropdown,
                            items: addClockProvider
                                .timeZoneRegionDropDownMenuItemList,
                          ),
                          DropdownButton<TimeZone>(
                            value: addClockProvider.timeZone,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            underline: Container(
                              height: 2,
                              color: Theme.of(context).appBarTheme.color,
                            ),
                            onChanged: addClockProvider.updateTimeZoneDropdown,
                            items: addClockProvider.timeZoneList,
                          ),
                          RaisedButton(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .title
                                    .color,
                              ),
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: addClockProvider.addButtonEnable
                                ? () => addClockProvider.addClockButtonListener(context)
                                : null,
                          ),
                        ],
                      ),
              );
            },
          ),
        );
      }),
    );
  }
}
