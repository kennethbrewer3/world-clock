/*
World Clock - Flutter app to display a list of clocks in different time zones.
Copyright (C) 2019  Kenneth B. Brewer III

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

kennethbrewer3@gmail.com
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/database/clock_dao.dart';
import 'package:world_clock/providers/clocks_provider.dart';
import 'package:world_clock/screens/details_screen.dart';
import 'package:world_clock/screens/main_screen.dart';

/// The main entry point of the app

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ClockDao _clockDao = ClockDao();
  ClocksProvider _clocksProvider = ClocksProvider();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Clock>>.value(
      initialData: List<Clock>(),
      value: _clockDao.getAllSortedByLabel(),
      child: Consumer<List<Clock>> (
        builder: (context, clockList, child) {
          return ChangeNotifierProxyProvider<List<Clock>, ClocksProvider>(
            initialBuilder: (_) => _clocksProvider,
            builder:  (_, clockList, futureNotifier) => _clocksProvider
            ..clocks = clockList,
            child: MaterialApp(
              title: 'International Clock',
              theme: ThemeData(
                primarySwatch: Colors.green,
              ),
              onGenerateRoute: routes,
            ),
          );
        },),);
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
          builder: (context) {
            return HomePage(title: 'International Clock');
          }
      );
    } else if (settings.name.startsWith("/clocks/")) {
      return MaterialPageRoute(
          builder: (context) {
            return ClockDetails(
                title: 'International Clock',
                detailsPath: settings.name
            );
          }
      );
    }
    return null;
  }
}
