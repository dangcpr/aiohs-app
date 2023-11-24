import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/update_price_laundry_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TopperCount extends StatefulWidget {
  const TopperCount({super.key});

  @override
  State<TopperCount> createState() => _TopperCountState();
}

class _TopperCountState extends State<TopperCount> {
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
                    if (infoLaundryCubit.state.topper >= 1) {
                      infoLaundryCubit
                          .updateTopper(infoLaundryCubit.state.topper - 1);
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
              infoLaundryCubit.state.topper.toString(),
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
                        .updateTopper(infoLaundryCubit.state.topper + 1);
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
