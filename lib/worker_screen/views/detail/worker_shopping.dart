import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/history/widgets/shopping/location_info.dart';
import 'package:rmservice/history/widgets/shopping/maid_info.dart';
import 'package:rmservice/history/widgets/shopping/work_info.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/dialog/dialog.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';

class WorkerShopping extends StatefulWidget {
  const WorkerShopping({super.key, required this.order});

  final ShoppingHistory order;

  @override
  State<WorkerShopping> createState() => _WorkerShoppingState();
}

class _WorkerShoppingState extends State<WorkerShopping> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
          title: Text("Chi tiết đơn - Đi chợ hộ",
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
              ))),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.locationLabel,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  // IconButton(
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateColor.resolveWith(
                  //       (states) => colorProject.primaryColor,
                  //     ),
                  //   ),
                  //   icon: Icon(color: Colors.white, Icons.edit),
                  //   onPressed: () {
                  //     showModalBottomSheet(
                  //       isScrollControlled: true,
                  //       context: context,
                  //       builder: (builder) {
                  //         return BottomEditNamePhone(isDarkMode: isDarkMode);
                  //       },
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
            LocationInfoShoppingHistory(
              isDarkMode: isDarkMode,
              order: widget.order,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.workingInfoLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: WorkInfoShoppingHistory(
                isDarkMode: isDarkMode,
                order: widget.order,
              ),
            ),
            if (widget.order.maid_name != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: "Thông tin người giúp việc",
                  isDarkMode: isDarkMode,
                ),
              ),
            if (widget.order.maid_code != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: HistoryMaidInfoShopping(
                  isDarkMode: isDarkMode,
                  order: widget.order,
                ),
              ),
            if (widget.order.maid_code == "") SizedBox(height: 15),
            if (widget.order.maid_code == "")
              ButtonGreenApp(
                  label: "Nhận đơn này",
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    try {
                      await WorkerController().acceptedOrder(widget.order.code,
                          context.read<UserCubit>().state.code!);
                      Navigator.pop(context);
                      showCustomDialog(
                          context: context,
                          dialogType: CustomDialogType.SUCCESS,
                          msg: "Bạn đã nhận đơn này",
                          isMultipleButton: false);
                    } catch (e) {
                      Navigator.pop(context);
                      showCustomDialog(
                          context: context,
                          dialogType: CustomDialogType.FAILURE,
                          msg: e.toString(),
                          isMultipleButton: false);
                    }
                  }),
            if (widget.order.maid_code == context.read<UserCubit>().state.code)
              SizedBox(height: 15),
            if (widget.order.maid_code ==
                    context.read<UserCubit>().state.code &&
                widget.order.status == "new")
              ButtonGreenApp(label: "Hủy đơn này", onPressed: null),
            if (widget.order.maid_code == context.read<UserCubit>().state.code)
              SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
