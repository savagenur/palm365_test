import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm365_test/features/product/presentation/bloc/cart_product/cart_product_bloc.dart';

class CartList extends StatelessWidget {
  final bool isCartPage;
  const CartList({super.key, this.isCartPage = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartProductBloc, CartProductState>(
      builder: (context, cartProductState) {
        if (cartProductState is CartProductLoaded) {
          final cartProducts = cartProductState.cartProducts;
          return isCartPage && cartProducts.isEmpty
              ? Center(
                  child: Text(
                    "There are no products!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ColoredBox(
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      if (cartProducts.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      ...List.generate(
                        cartProducts.length,
                        (index) {
                          final cartProduct = cartProducts[index];
                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  cartProduct.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              cartProduct.name!,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<CartProductBloc>().add(
                                          UpdateCartProduct(
                                            product: cartProduct.copyWith(
                                              amount: cartProduct.amount! + 1,
                                            ),
                                          ),
                                        );
                                  },
                                  icon: Icon(
                                    Icons.add,
                                  ),
                                ),
                                Text(
                                  "${cartProduct.amount}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cartProduct.amount == 1) {
                                      context.read<CartProductBloc>().add(
                                            DeleteCartProduct(
                                              id: cartProduct.id!,
                                            ),
                                          );
                                    } else {
                                      context.read<CartProductBloc>().add(
                                            UpdateCartProduct(
                                              product: cartProduct.copyWith(
                                                amount: cartProduct.amount! - 1,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (cartProducts.isNotEmpty)
                        Divider(
                          thickness: 5,
                        ),
                    ],
                  ),
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
