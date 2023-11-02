import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/widgets/every_product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    List<String> listProduct = context.watch<AddItemCubit>().state;
    return Column(
      children: List.generate(
        listProduct.length,
        (index) {
          return Column(
            children: [
              EveryProduct(
                product: listProduct[index],
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
