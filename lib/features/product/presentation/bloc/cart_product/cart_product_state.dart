part of 'cart_product_bloc.dart';

sealed class CartProductState extends Equatable {
  final List<ProductEntity> cartProducts;
  const CartProductState([this.cartProducts = const []]);

  @override
  List<Object> get props => [
        cartProducts,
      ];
}

final class CartProductInitial extends CartProductState {}

final class CartProductLoaded extends CartProductState {
  const CartProductLoaded(super.cartProducts);
}
