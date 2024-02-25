import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/models/product_buy.dart';
import 'package:rmservice/shopping/widgets/every_product.dart';
import 'package:rmservice/utilities/components/empty_card.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key, required this.isRemove});

  final bool isRemove;

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    List<ProductBuy> listProduct = context.watch<AddItemCubit>().state;
    return listProduct.isEmpty
        ? WorkerEmptyOrder(
            title: "Không có sản phẩm",
            desc: "Không có sản phẩm muốn mua. Vui lòng thêm sản phẩm.")
        : Column(
              children: List.generate(
                listProduct.length,
                (index) {
                  return Column(
                    children: [
                      EveryProduct(
                          product: listProduct[index],
                          isRemove: widget.isRemove),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            
          );
  }
}
