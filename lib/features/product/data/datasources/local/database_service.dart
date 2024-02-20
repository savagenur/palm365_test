import 'package:palm365_test/features/product/data/repositories/cart_repo_impl.dart';
import 'package:palm365_test/features/product/data/repositories/product_repo_impl.dart';
import 'package:palm365_test/injection_container.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "product.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    // await database.delete(ProductRepoImpl.tableName);
    await ProductRepoImpl(database: database).createProductTable(database);
    await CartRepoImpl(database: database).createCartProductTable(database);
  }
}
