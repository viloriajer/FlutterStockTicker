import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;
import 'package:stock_watcher/models/stock.dart';

class DatabaseHelper {
  sqflitePackage.Database db;

  Future<void> getOrCreateDatabaseHandle() async {
    var databasesPath = await sqflitePackage.getDatabasesPath();
    print('$databasesPath');
    var path = pathPackage.join(databasesPath, 'stock_database.db');
    print('$path');
    db = await sqflitePackage.openDatabase(
      path,
      onCreate: (sqflitePackage.Database db1, int version) async {
        await db1.execute(
          "CREATE TABLE stocks(symbol TEXT PRIMARY KEY, name TEXT, price REAL)",
        );
      },
      version: 1,
    );
    print('$db');
  }

  Future<void> insertStock(Stock stock) async {
    await db.insert(
      'stocks',
      stock.toMap(),
      conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
    );
  }

  Future<void> printAllStocksInDb() async {
    List<Stock> listOfStocks = await this.getAllStocksFromDb();
    if (listOfStocks.length == 0) {
      print('No Stocks in the list');
    } else {
      listOfStocks.forEach((stock) {
        print(
            'Stock{symbol: ${stock.symbol}, name: ${stock.name}, price: ${stock.price}');
      });
    }
  }

  Future<List<Stock>> getAllStocksFromDb() async {
    final List<Map<String, dynamic>> stockMap = await db.query('stocks');
    return List.generate(stockMap.length, (i) {
      return Stock(
        symbol: stockMap[i]['symbol'],
        name: stockMap[i]['name'],
        price: stockMap[i]['price'],
      );
    });
  }

  Future<void> updateStock(Stock stock) async {
    await db.update(
      'stocks',
      stock.toMap(),
      where: "symbol = ?",
      whereArgs: [stock.symbol],
    );
  }

  Future<void> deleteStock(Stock stock) async {
    await db.delete(
      'stocks',
      where: "symbol = ?",
      whereArgs: [stock.symbol],
    );
  }
}
