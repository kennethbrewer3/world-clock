import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/database/clock_dao.dart';
import 'package:world_clock/providers/clocks_provider.dart';
import 'package:world_clock/screens/details_screen.dart';
import 'package:world_clock/screens/main_screen.dart';

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
