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

import 'package:sembast/sembast.dart';
import 'package:world_clock/data/clock.dart';
import 'package:world_clock/database/app_database.dart';

class ClockDao {
  static const String CLOCK_STORE_NAME = "clocks";

  final _clockStore = intMapStoreFactory.store(CLOCK_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert (Clock clock) async {
    await _clockStore.add(await _db, clock.toMap());
  }

  Future update(Clock clock) async {
    final finder = Finder(filter: Filter.byKey(clock.id));
    await _clockStore.update(await _db, clock.toMap(), finder: finder);
  }

  Future delete(Clock clock) async {
    final finder = Finder(filter: Filter.byKey(clock.id));
    await _clockStore.delete(await _db, finder: finder);
  }

  Future<List<Clock>> getAllSortedByLabel() async {
    final finder = Finder(sortOrders: [SortOrder('label')]);

    final recordSnapshots = await _clockStore.find(
      await _db,
      finder: finder
    );

    return recordSnapshots.map((snapshot) {
      final clock = Clock.fromMap(snapshot.value);
      clock.id = snapshot.key;
      return clock;
    }).toList();
  }
}