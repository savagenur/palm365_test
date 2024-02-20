import 'package:flutter/material.dart';
import 'package:palm365_test/features/product/presentation/widgets/cart_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart products"),
        backgroundColor: Colors.amber.shade200,
      ),
      body: const CartList(),
    );
  }
}
