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