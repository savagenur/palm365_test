import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm365_test/features/product/presentation/bloc/cart_product/cart_product_bloc.dart';
import 'package:palm365_test/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:palm365_test/features/product/presentation/pages/product_page.dart';
import 'package:palm365_test/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(FetchAllProducts()),
        ),
        BlocProvider(
          create: (context) => sl<CartProductBloc>()..add(FetchCartProducts()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Palm365 Test",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductPage(),
      ),
    );
  }
}
