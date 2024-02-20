import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class CartRepository {
  Future<void> createCartProductTable(Database database);
  Future<int> createCartProduct({
  required ProductEntity product
  });
  Future<List<ProductEntity>> fetchAllCartProducts();
  Future<ProductEntity> fetchCartProductById(int id);
  Future<void> deleteCartProduct(int id);
  Future<int> updateCartProduct({
     required ProductEntity product,

  });
}
