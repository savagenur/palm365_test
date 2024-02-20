import 'package:palm365_test/features/product/data/datasources/local/database_service.dart';
import 'package:palm365_test/features/product/data/models/product_model.dart';
import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:palm365_test/features/product/domain/repositories/cart_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class CartRepoImpl extends CartRepository {
  static const tableName = "cart_products";
  final Database database;

  CartRepoImpl({required this.database});
  @override
  Future<void> createCartProductTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "groupId" INTEGER NOT NULL,
      "price" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "imageUrl" TEXT,
      "description" TEXT NOT NULL,
      "amount" INTEGER NOT NULL,
      "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      "updatedAt" INTEGER,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  @override
  Future<int> createCartProduct({
    required ProductEntity product,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name,description,price,createdAt,groupId,imageUrl,amount) VALUES (?,?,?,?,?,?,?)''',
      [
        product.name,
        product.description,
        product.price,
        DateTime.now().millisecondsSinceEpoch,
        product.groupId,
        product.imageUrl,
        1,
      ],
    );
  }

  @override
  Future<List<ProductModel>> fetchAllCartProducts() async {
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
  Future<ProductModel> fetchCartProductById(int id) async {
    final database = await DatabaseService().database;
    final product = await database.rawQuery(
      '''SELECT * FROM $tableName WHERE id = ?''',
      [id],
    );
    return ProductModel.fromJson(product.first);
  }

  @override
  Future<void> deleteCartProduct(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete(
      '''DELETE FROM $tableName WHERE id = ?''',
      [id],
    );
  }

  @override
  Future<int> updateCartProduct({
    required ProductEntity product,
  }) async {
    final database = await DatabaseService().database;
    final productModel = ProductModel.fromEntity(product);
    return await database.update(
      tableName,
      productModel.toJson(),
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [productModel.id!],
    );
  }
}
