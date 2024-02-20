import 'package:get_it/get_it.dart';
import 'package:palm365_test/features/product/data/datasources/local/database_service.dart';
import 'package:palm365_test/features/product/data/models/product_model.dart';
import 'package:palm365_test/features/product/data/repositories/cart_repo_impl.dart';
import 'package:palm365_test/features/product/data/repositories/product_repo_impl.dart';
import 'package:palm365_test/features/product/domain/repositories/cart_repository.dart';
import 'package:palm365_test/features/product/domain/repositories/product_repository.dart';
import 'package:palm365_test/features/product/domain/usecases/product/fetch_all_product.dart';
import 'package:palm365_test/features/product/presentation/bloc/cart_product/cart_product_bloc.dart';
import 'package:palm365_test/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final databaseService = DatabaseService();

  final database = await databaseService.database;
 sl.registerSingleton(
    () => databaseService,
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepoImpl(database: database),
  );
  sl.registerLazySingleton(
    () => FetchAllProductsUsecase(sl.call()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepoImpl(database: database),
  );

  sl.registerLazySingleton(
    () => ProductBloc(
      fetchAllProductsUsecase: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => CartProductBloc(
      sl.call(),
    ),
  );

  _initMocks();
}

Future _initMocks() async {
  final sp = await SharedPreferences.getInstance();
  final isFirstInit = sp.getBool("firstInit") ?? true;

  final List<ProductModel> mockProducts = [
    ...List.generate(
      8,
      (index) => ProductModel(
          name: "Product $index",
          groupId: 1,
          price: 100 + (index * 2),
          imageUrl:
              "https://food-images.files.bbci.co.uk/food/recipes/rainbow_cake_20402_16x9.jpg",
          description:
              "description description description description description "),
    ),
    ...List.generate(
      8,
      (index) => ProductModel(
          name: "Product $index",
          groupId: 2,
          price: 200 + (index * 5),
          imageUrl:
              "https://eu-markets.com/wp-content/uploads/2021/05/Coca-Cola-500-ml.jpg",
          description:
              "description description description description description "),
    ),
  ];
  if (isFirstInit) {
    await Future.wait(
      mockProducts.map(
        (e) => sl<ProductRepository>().createProduct(
          name: e.name!,
          description: e.description!,
          price: e.price!,
          groupId: e.groupId!,
          imageUrl: e.imageUrl!,
        ),
      ),
    );
    await sp.setBool("firstInit", false);
  }
}
//  String databasePath = await getDatabasesPath();
//   String path = join(databasePath, 'product.db');
//   // await deleteDatabase(path);
//   // await database.execute('DROP TABLE IF EXISTS ${ProductRepoImpl.tableName}');
  