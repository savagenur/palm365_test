import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:palm365_test/features/product/domain/repositories/cart_repository.dart';
import 'package:palm365_test/injection_container.dart';

part 'cart_product_event.dart';
part 'cart_product_state.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  final CartRepository repository;
  CartProductBloc(this.repository) : super(CartProductInitial()) {
    on<CartProductEvent>((event, emit) {});
    on<FetchCartProducts>(_onFetchCartProducts);
    on<CreateCartProduct>(_onCreateCartProduct);
    on<UpdateCartProduct>(_onUpdateCartProduct);
    on<DeleteCartProduct>(_onDeleteCartProduct);
  }

  FutureOr<void> _onFetchCartProducts(
      FetchCartProducts event, Emitter<CartProductState> emit) async {
    final cartProducts = await repository.fetchAllCartProducts();
    emit(CartProductLoaded(cartProducts));
  }

  FutureOr<void> _onCreateCartProduct(
      CreateCartProduct event, Emitter<CartProductState> emit) async {
    await repository.createCartProduct(product: event.product);
    final cartProducts = await repository.fetchAllCartProducts();
    emit(CartProductLoaded(cartProducts));
  }

  FutureOr<void> _onUpdateCartProduct(
      UpdateCartProduct event, Emitter<CartProductState> emit) async {
    await repository.updateCartProduct(product: event.product);
    final cartProducts = await repository.fetchAllCartProducts();
    emit(CartProductLoaded(cartProducts));
  }

  FutureOr<void> _onDeleteCartProduct(
      DeleteCartProduct event, Emitter<CartProductState> emit) async {
    await repository.deleteCartProduct(event.id);
    final cartProducts = await repository.fetchAllCartProducts();
    emit(CartProductLoaded(cartProducts));
  }
}
