import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/providers/add_clock_provider.dart';

class AddClockBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddClockProvider>(
        builder: (context) => AddClockProvider(),
      child: Consumer<AddClockProvider>(
          builder: (context, addClockProvider, child) =>
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Add Clock",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).appBarTheme.color
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Clock label",
                ),
                textAlign: TextAlign.center,
                autofocus: true,
              ),
              DropdownButton<String>(
                value: addClockProvider.timeZoneRegion,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Theme
                      .of(context)
                      .appBarTheme
                      .color,
                ),
                onChanged: addClockProvider.updateTimeZoneRegionDropdown,
                items: addClockProvider.timeZoneRegionList,
              ),
              FlatButton(
                child: Text(
                    "Add",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentTextTheme
                        .title
                        .color,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
