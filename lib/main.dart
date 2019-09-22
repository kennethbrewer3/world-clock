import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/providers/clocks_provider.dart';
import 'package:world_clock/screens/details_screen.dart';
import 'package:world_clock/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClocksProvider>(
      builder: (context) => ClocksProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: routes,
      ),
    );
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
