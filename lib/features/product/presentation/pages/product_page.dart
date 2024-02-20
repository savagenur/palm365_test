import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
import 'package:palm365_test/features/product/presentation/bloc/cart_product/cart_product_bloc.dart';
import 'package:palm365_test/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm365_test/features/product/presentation/pages/cart_page.dart';
import 'package:palm365_test/features/product/presentation/widgets/cart_list.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ));
            },
            icon: Icon(
              Icons.shopping_cart,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const CartList(
            isCartPage: false,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              if (productState is ProductLoaded) {
                return Expanded(
                  child: GroupedListView<ProductEntity, int>(
                    elements: productState.products,
                    groupBy: (element) => element.groupId!,
                    groupSeparatorBuilder: (groupId) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Group $groupId",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    indexedItemBuilder: (context, product, index) {
                      return ListTile(
                        trailing: OutlinedButton(
                            onPressed: () {
                              context.read<CartProductBloc>().add(
                                    CreateCartProduct(
                                      product: product,
                                    ),
                                  );
                            },
                            child: Icon(Icons.add)),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          product.name!,
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
