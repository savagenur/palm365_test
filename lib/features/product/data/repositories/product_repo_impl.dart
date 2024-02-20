import 'package:palm365_test/features/product/data/datasources/local/database_service.dart';
import 'package:palm365_test/features/product/data/models/product_model.dart';
import 'package:palm365_test/features/product/domain/repositories/product_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductRepoImpl extends ProductRepository {
  static const tableName = "products";
  final Database database;

  ProductRepoImpl({required this.database});
  @override
  Future<void> createProductTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "groupId" INTEGER NOT NULL,
      "price" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "imageUrl" TEXT,
      "description" TEXT NOT NULL,
      "amount" INTEGER,
      "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      "updatedAt" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  @override
  Future<int> createProduct({
    required String name,
    required String description,
    required String imageUrl,
    required int price,
    required int groupId,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name,description,price,createdAt,groupId,imageUrl) VALUES (?,?,?,?,?,?)''',
      [
        name,
        description,
        price,
        DateTime.now().millisecondsSinceEpoch,
        groupId,
        imageUrl,
      ],
    );
  }

  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    final database = await DatabaseService().database;
    final products = await database.rawQuery(
        '''SELECT * FROM $tableName ORDER BY COALESCE(updatedAt, createdAt)''');
    return products
        .map(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
  }

  @override
  Future<ProductModel> fetchProductById(int id) async {
    final database = await DatabaseService().database;
    final product = await database.rawQuery(
      '''SELECT * FROM $tableName WHERE id = ?''',
      [id],
    );
    return ProductModel.fromJson(product.first);
  }

  @override
  Future<void> deleteProduct(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''DELETE FROM $tableName WHERE id = ?''',
      [id],
    );
  }

  @override
  Future<int> updateProduct({
    required int id,
    required String name,
  }) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        "name": name,
        "updatedAt": DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }
}
