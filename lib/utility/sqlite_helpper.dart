import 'package:flutter_myappication_1/models/splite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelpper {
  final String nameDetabase = 'shopping.db';
  final int version = 1;
  final String tableDatabase = 'tableOrder';
  final String columId = 'id';
  final String columIdProduct = 'idProduct';
  final String columNameProduct = 'nameProduct';
  final String columPriceProduct = 'priceProduct';
  final String columAmount = 'amount';
  final String columSum = 'sum';

  SQLiteHelpper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDetabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDatabase ($columId INTEGER PRIMARY KEY, $columIdProduct TEXT, $columNameProduct TEXT, $columPriceProduct TEXT, $columAmount TEXT, $columSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), nameDetabase),
    );
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database database = await connectedDatabase();
    List<SQLiteModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    print('### maps on SQLiteHelper ==>> $maps');
    for (var item in maps) {
      SQLiteModel model = SQLiteModel.fromMap(item);
      results.add(model);
    }
    return results;
  }

  Future<Null> insertValueSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();
    await database.insert(tableDatabase, sqLiteModel.toMap()).then(
          (value) =>
              print('### insert Value name ==>> ${sqLiteModel.nameProduct}'),
        );
  }

  Future<void> deleteSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase, where: '$columId = $id').then(
          (value) => print('### Success Delete id ==>> $id'),
        );
  }

  Future<void> emptySQLite() async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase).then(
          (value) => print('### Empty SQLite Success'),
        );
  }
}
