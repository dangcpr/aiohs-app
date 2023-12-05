import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/user_address/cubits/get_user_address/get_user_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/views/maps.dart';
import 'package:rmservice/user_address/widgets/address_card.dart';
import 'package:rmservice/user_address/widgets/empty_address.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class GetUserAddressScreen extends StatefulWidget {
  const GetUserAddressScreen({super.key});

  @override
  State<GetUserAddressScreen> createState() => _GetUserAddressScreenState();
}

class _GetUserAddressScreenState extends State<GetUserAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final getUserAddressCubit = context.watch<GetUserAddressCubit>();
    String code = context.read<UserCubit>().state.code!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Địa chỉ đã lưu',
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            fontFamily: fontBoldApp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 90),
        child: RefreshIndicator(
          color: colorProject.primaryColor,
          onRefresh: () async {
            List<AddressResponse> list =
                await UserAddressController().getAddress(code);
            getUserAddressCubit.setListUserAddress(list);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: getUserAddressCubit.state.isEmpty
                ? EmptyAddress()
                : Column(
                    children: [
                      for (int i = 0; i < getUserAddressCubit.state.length; i++)
                        AddressCard(
                          address: getUserAddressCubit.state[i],
                        ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: ButtonGreenApp(
          label: "Thêm địa chỉ mới",
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: ChooseLocationScreenUser(),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
