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
    initislDatabase();
  }

  Future<Null> initislDatabase() async {
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

  

}
