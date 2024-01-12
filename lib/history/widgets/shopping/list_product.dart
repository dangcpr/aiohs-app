import 'package:flutter/material.dart';
import 'package:rmservice/shopping/models/product_buy_request.dart';
import 'package:rmservice/shopping/widgets/every_product.dart';

class ListProductHistory extends StatefulWidget {
  const ListProductHistory({super.key, required this.isRemove, required this.listProduct});

  final bool isRemove;
  final List<ProductBuyRequest> listProduct;

  @override
  State<ListProductHistory> createState() => _ListProductHistoryState();
}

class _ListProductHistoryState extends State<ListProductHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.listProduct.length,
        (index) {
          return Column(
            children: [
              EveryProduct(
                productRequest: widget.listProduct[index],
                isRemove: widget.isRemove,
                isNetwork: true,
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
