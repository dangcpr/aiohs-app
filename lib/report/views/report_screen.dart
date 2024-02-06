import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/report/controllers/report.dart';
import 'package:rmservice/report/widgets/card_report.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController from_date_controller = TextEditingController();
  TextEditingController to_date_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thống kê",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Từ ngày",
                  style: TextStyle(
                    fontSize: fontSize.mediumLarger,
                    fontFamily: fontBoldApp,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFieldBasic(
                    isDarkMode: MediaQuery.of(context).platformBrightness ==
                        Brightness.dark,
                    controller: from_date_controller,
                    hintText: "Từ ngày",
                    isReadOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: colorProject.primaryColor,
                              colorScheme: ColorScheme.light(primary: colorProject.primaryColor),
                              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: fromDate ?? DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          fromDate = date;
                        });
                        if (toDate == null || fromDate!.isAfter(toDate!)) {
                          toDate = fromDate;
                          to_date_controller.text =
                              "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}";
                        }
                        from_date_controller.text =
                            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      }
                    },
                  ),
                ),
              ],
            ),
            if (fromDate != null) const SizedBox(height: 20),
            if (fromDate != null)
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Đến ngày",
                    style: TextStyle(
                      fontSize: fontSize.mediumLarger,
                      fontFamily: fontBoldApp,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldBasic(
                      isDarkMode: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark,
                      controller: to_date_controller,
                      hintText: "Đến ngày",
                      isReadOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: colorProject.primaryColor,
                                colorScheme: ColorScheme.light(primary: colorProject.primaryColor),
                                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate: toDate ?? DateTime.now(),
                          firstDate: fromDate!,
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            toDate = date;
                          });
                          to_date_controller.text =
                              "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: ReportController().getReport(userCubit.state.code!,
                    from_date_controller.text, to_date_controller.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: colorProject.primaryColor,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Lỗi: ${snapshot.error}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if (userCubit.state.role == "maid")
                          CardReport(
                              title: "Tổng số đơn đã nhận",
                              value: snapshot.data!.total_received_order
                                  .toDouble(),
                              icon: Icons.numbers),
                        if (userCubit.state.role == "maid")
                          SizedBox(height: 20),
                        if (userCubit.state.role == "maid")
                          CardReport(
                              title: "Doanh thu (Việt Nam Đồng)",
                              value: snapshot.data!.received_amount.toDouble(),
                              icon: Icons.money),
                        if (userCubit.state.role == "maid")
                          SizedBox(height: 20),
                        CardReport(
                            title: "Tổng số đơn đã đặt",
                            value: snapshot.data!.total_rental_order.toDouble(),
                            icon: Icons.numbers),
                        SizedBox(height: 20),
                        CardReport(
                            title: "Số tiền đã trả (Việt Nam Đồng)",
                            value: snapshot.data!.rental_amount.toDouble(),
                            icon: Icons.shopping_cart),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
