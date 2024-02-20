import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:palm365_test/features/product/domain/repositories/product_repository.dart';

class FetchAllProductsUsecase {
  final ProductRepository repository;

  FetchAllProductsUsecase(this.repository);
  Future<List<ProductEntity>> call() async {
    return repository.fetchAllProducts();
  }
}
