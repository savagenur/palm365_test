import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class ProductRepository {
  Future<void> createProductTable(Database database);
  Future<int> createProduct({
    required String name,
    required String description,
    required String imageUrl,
    required int price,
    required int groupId,
  });
  Future<List<ProductEntity>> fetchAllProducts();
  Future<ProductEntity> fetchProductById(int id);
  Future<void> deleteProduct(int id);
  Future<int> updateProduct({
    required int id,
    required String name,
  });
}
