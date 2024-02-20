part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  final List<ProductEntity> products;
  const ProductState([this.products = const []]);

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoaded extends ProductState {
  const ProductLoaded(super.products);
}
