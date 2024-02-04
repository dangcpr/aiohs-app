// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/main_page/widgets/button_post_job.dart';
import 'package:rmservice/maid_near/widgets/maid_near.dart';
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/utilities/constants/app_assets.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/worker_register/views/register_step1.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_state.dart';
import 'package:rmservice/worker_screen/views/worker_screen.dart';
import '../../utilities/widget/listview_horizontal.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  ValueListenable<double> distanceMaidNear = ValueNotifier(5.0);
  ValueListenable<int> starMaidNear = ValueNotifier(3);

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // bool darkMode = Theme.of(context).brightness == Brightness.dark;
    //context.read<GetProductCubit>().getProduct();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(
                  context.watch<UserCubit>().state.full_name == ""
                      ? context.watch<UserCubit>().state.email
                      : context.watch<UserCubit>().state.full_name,
                  context.watch<UserCubit>().state.avatar_url!),
              const SizedBox(height: 12),
              //Register(),
              context.read<UserCubit>().state.role == "normal"
                  ? Register()
                  : maidCard(),
              const SizedBox(height: 12),
              //SearchBox(),
              //const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.services,
                style: const TextStyle(
                  fontFamily: fontBoldApp,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              HorizontalListViewWithIndicator(),
              const SizedBox(height: 15),

              MaidNear(),
              const SizedBox(height: 15),
              ButtonPostJob(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileWidget(String name, String image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: 85,
            width: 85,
            child: image.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage('${image}'),
                    radius: 50,
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage(AppAssets.profile),
                    radius: 50,
                  )),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.hello,
                style: const TextStyle(
                  fontFamily: fontApp,
                  fontSize: fontSize.large,
                  color: colorProject.subColor,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.large,
                  color: colorProject.primaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Register() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      width: size.width,
      decoration: BoxDecoration(
        //color: colorProject.primaryColor.withOpacity(0.4),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 0, 223, 156),
            Color.fromARGB(255, 78, 252, 255),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.becomeAMaid,
              style: const TextStyle(
                fontFamily: fontApp,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: WorkerRegisterStep1Screen(),
                  ),
                );
              },
              child: Container(
                height: 27,
                width: 102,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: const TextStyle(
                      fontFamily: fontBoldApp,
                      color: colorProject.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget maidCard() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      width: size.width,
      decoration: BoxDecoration(
        //color: colorProject.primaryColor.withOpacity(0.4),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 0, 223, 156),
            Color.fromARGB(255, 78, 252, 255),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Bạn muốn nhận việc để giúp việc?",
                style: const TextStyle(
                  fontFamily: fontApp,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return PopScope(
                      canPop: false,
                      child: const Center(
                          child: CircularProgressIndicator(
                              color: colorProject.primaryColor)),
                    );
                  },
                );
                int length = (await UserAddressController()
                        .getAddress(context.read<UserCubit>().state.code!))
                    .length;
                if (length == 0) {
                  Navigator.pop(context);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Không tìm thấy địa chỉ',
                    desc:
                        'Vui lòng thêm lưu địa chỉ mặc định trước khi nhận việc',
                  ).show();
                  return;
                }
                Navigator.pop(context);
                if (context.read<WorkerGetOrderAllCubit>().state
                    is WorkerGetOrderAllInitial) {
                  context
                      .read<WorkerGetOrderAllCubit>()
                      .getOrderAll(context.read<UserCubit>().state.code!, distance: 5.0);
                }

                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: WorkerScreen(),
                  ),
                );
              },
              child: Container(
                height: 27,
                width: 102,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "Nhận việc",
                    style: const TextStyle(
                      fontFamily: fontBoldApp,
                      color: colorProject.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SearchBox() {
    final TextEditingController _searchText = TextEditingController();
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: _searchText,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: colorProject.primaryColor,
          ),
          suffixIcon: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              _searchText.clear();
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorProject.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: AppLocalizations.of(context)!.search,
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        style: const TextStyle(
          fontFamily: fontApp,
        ),
        cursorColor: colorProject.primaryColor,
      ),
    );
  }

  // Widget Appbar() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           Image.asset(
  //             'assets/images/logo.png',
  //             height: 50,
  //             width: 50,
  //           ),
  //           const SizedBox(width: 10),
  //           const Text(
  //             'AIOHS',
  //             style: TextStyle(
  //               fontFamily: fontBoldApp,
  //               fontSize: fontSize.large,
  //               color: colorProject.primaryColor,
  //             ),
  //           ),
  //         ],
  //       ),
  //       const Row(
  //         children: [
  //           Icon(
  //             Icons.notifications,
  //             color: colorProject.primaryColor,
  //           ),
  //           SizedBox(width: 20),
  //           Icon(
  //             Icons.account_circle_sharp,
  //             color: colorProject.primaryColor,
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
