// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFavoriteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteDatabaseBuilder databaseBuilder(String name) =>
      _$FavoriteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FavoriteDatabaseBuilder(null);
}

class _$FavoriteDatabaseBuilder {
  _$FavoriteDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FavoriteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FavoriteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FavoriteDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FavoriteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FavoriteDatabase extends FavoriteDatabase {
  _$FavoriteDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteDao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorite` (`id` TEXT, `imageUrl` TEXT, `name` TEXT, `city` TEXT, `rating` TEXT, `isFavorite` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteDao get dao {
    return _daoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteRestaurantInsertionAdapter = InsertionAdapter(
            database,
            'favorite',
            (FavoriteRestaurant item) => <String, Object?>{
                  'id': item.id,
                  'imageUrl': item.imageUrl,
                  'name': item.name,
                  'city': item.city,
                  'rating': item.rating,
                  'isFavorite': item.isFavorite == null
                      ? null
                      : (item.isFavorite! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteRestaurant>
      _favoriteRestaurantInsertionAdapter;

  @override
  Future<List<FavoriteRestaurant>> getAllFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM favorite ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => FavoriteRestaurant(
            id: row['id'] as String?,
            imageUrl: row['imageUrl'] as String?,
            name: row['name'] as String?,
            city: row['city'] as String?,
            rating: row['rating'] as String?,
            isFavorite: row['isFavorite'] == null
                ? null
                : (row['isFavorite'] as int) != 0));
  }

  @override
  Future<void> deleteFavorite(String favoriteId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM favorite WHERE id = ?1',
        arguments: [favoriteId]);
  }

  @override
  Future<void> insertFavorite(FavoriteRestaurant favorite) async {
    await _favoriteRestaurantInsertionAdapter.insert(
        favorite, OnConflictStrategy.replace);
  }
}
