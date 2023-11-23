import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/update_price_laundry_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ClothesCount extends StatefulWidget {
  const ClothesCount({super.key});

  @override
  State<ClothesCount> createState() => _ClothesCountState();
}

class _ClothesCountState extends State<ClothesCount> {
  @override
  Widget build(BuildContext context) {
    var infoLaundryCubit = context.watch<SaveInfoLaundryCubit>();

    return Container(
      width: MediaQuery.of(context).size.width / 2.75,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding.paddingSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorProject.primaryColor),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (infoLaundryCubit.state.clothes >= 1) {
                      infoLaundryCubit
                          .updateClothes(infoLaundryCubit.state.clothes - 1);
                      infoLaundryCubit.updateTotalPrice(
                          context.read<PriceLaundryCubit>().state);

                      debugPrint(infoLaundryCubit.state.totalPrice.toString());
                    }
                  });
                  context.read<UpdatePriceLaundryCubit>().updatePriceLaundry(
                      context.read<SaveInfoLaundryCubit>().state.totalPrice);
                },
                child: Icon(Icons.remove),
              ),
            ),
            Text(
              infoLaundryCubit.state.clothes.toString(),
              style: textStyle.headerStyle(fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorProject.primaryColor),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    infoLaundryCubit
                        .updateClothes(infoLaundryCubit.state.clothes + 1);
                    infoLaundryCubit.updateTotalPrice(
                        context.read<PriceLaundryCubit>().state);
                    debugPrint(infoLaundryCubit.state.totalPrice.toString());
                  });
                  context.read<UpdatePriceLaundryCubit>().updatePriceLaundry(
                      context.read<SaveInfoLaundryCubit>().state.totalPrice);
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
