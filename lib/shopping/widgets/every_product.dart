import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class EveryProduct extends StatefulWidget {
  const EveryProduct({super.key, required this.product});

  final String product;

  @override
  State<EveryProduct> createState() => _EveryProductState();
}

class _EveryProductState extends State<EveryProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.product,
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.medium,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              context.read<AddItemCubit>().removeItem(widget.product);
            },
            child: Image.asset(AppAssets.trashImage),
          )
        ],
      ),
    );
  }
}
