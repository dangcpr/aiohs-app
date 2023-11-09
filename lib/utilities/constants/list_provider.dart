import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/save_price_shopping.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';

import '../../cleaning_hourly/cubits/save_info/save_info.dart';
import '../../cleaning_longterm/cubit/save_info_cubit.dart';

final listProvider = [
  BlocProvider<SetFirstTimeCubit>(
    create: (_) => SetFirstTimeCubit(),
  ),
  BlocProvider<GetFirstTimeCubit>(
    create: (_) => GetFirstTimeCubit(),
  ),
  BlocProvider<LoginCubit>(
    create: (_) =>
        LoginCubit(authenticationRepository: AuthenticationRepository()),
  ),
  BlocProvider<SignupCubit>(
    create: (_) => SignupCubit(),
  ),
  BlocProvider<SaveAddressCubit>(
    create: (_) => SaveAddressCubit(),
  ),
  BlocProvider<SaveAddressShoppingCubit>(
    create: (_) => SaveAddressShoppingCubit(),
  ),
  BlocProvider<SaveInfoCleaningHourlyCubit>(
    create: (_) => SaveInfoCleaningHourlyCubit(),
  ),
  BlocProvider<SaveDataShopping>(
    create: (_) => SaveDataShopping(),
  ),
  BlocProvider<AddItemCubit>(
    create: (_) => AddItemCubit(),
  ),
  BlocProvider<SavePriceShopping>(
    create: (_) => SavePriceShopping(),
  ),
  BlocProvider<SaveInfoCleaningLongTermCubit>(
    create: (_) => SaveInfoCleaningLongTermCubit(),
  ),
  BlocProvider<SaveInfoAirConditioningCleaningCubit>(
    create: (_) => SaveInfoAirConditioningCleaningCubit(),
  ),
];
