import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:palm365_test/features/product/domain/usecases/product/fetch_all_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchAllProductsUsecase fetchAllProductsUsecase;
  ProductBloc({
    required this.fetchAllProductsUsecase,
  }) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<FetchAllProducts>(_onFetchAllProducts);
  }

  FutureOr<void> _onFetchAllProducts(
      FetchAllProducts event, Emitter<ProductState> emit) async {
    final products = await fetchAllProductsUsecase.call();
    emit(ProductLoaded(products));
  }
}
