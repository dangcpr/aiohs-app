import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class WeedingDressCount extends StatefulWidget {
  const WeedingDressCount({super.key});

  @override
  State<WeedingDressCount> createState() => _WeedingDressCountState();
}

class _WeedingDressCountState extends State<WeedingDressCount> {
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
                  if(infoLaundryCubit.state.weedingDress < 1) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWrong(
                          notification: "Số lượng không thể nhỏ hơn 0",
                        );
                      },
                    );
                    return;
                  }
                  setState(() {
                    if (infoLaundryCubit.state.weedingDress >= 1) {
                      infoLaundryCubit.updateWeedingDress(
                          infoLaundryCubit.state.weedingDress - 1);

                      context
                          .read<CalculateLaundryCubit>()
                          .calculateLaundry(infoLaundryCubit.state);
                      debugPrint(infoLaundryCubit.state.totalPrice.toString());
                    }
                  });
                },
                child: Icon(Icons.remove),
              ),
            ),
            Text(
              infoLaundryCubit.state.weedingDress.toString(),
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
                    infoLaundryCubit.updateWeedingDress(
                        infoLaundryCubit.state.weedingDress + 1);

                    debugPrint(infoLaundryCubit.state.totalPrice.toString());
                  });
                  context
                      .read<CalculateLaundryCubit>()
                      .calculateLaundry(infoLaundryCubit.state);
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
