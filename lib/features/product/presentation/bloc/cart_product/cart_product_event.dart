part of 'cart_product_bloc.dart';

sealed class CartProductEvent extends Equatable {
  const CartProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchCartProducts extends CartProductEvent {}

final class CreateCartProduct extends CartProductEvent {
  final ProductEntity product;

  CreateCartProduct({required this.product});
}

final class UpdateCartProduct extends CartProductEvent {
  final ProductEntity product;
  UpdateCartProduct({required this.product});

}

final class DeleteCartProduct extends CartProductEvent {

  final int id;
  DeleteCartProduct({required this.id});
}
