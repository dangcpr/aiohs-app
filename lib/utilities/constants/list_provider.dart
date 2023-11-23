import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_cubit.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/update_price_laundry_cubit.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/save_price_shopping.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';
import 'package:rmservice/worker_register/cubits/worker_cubit.dart';
import 'package:rmservice/worker_register/cubits/worker_register/worker_register_cubit.dart';

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
  BlocProvider<GetProductCubit>(
    create: (_) => GetProductCubit(),
  ),
  BlocProvider<UserCubit>(
    create: (_) => UserCubit(),
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
  BlocProvider<WorkerCubit>(
    create: (_) => WorkerCubit(),
  ),
  BlocProvider<WorkerRegisterCubit>(
    create: (_) => WorkerRegisterCubit(),
  ),

  //Laundry
  BlocProvider<SaveInfoLaundryCubit>(
    create: (_) => SaveInfoLaundryCubit(),
  ),
  BlocProvider<GetPriceLaundryCubit>(
    create: (_) => GetPriceLaundryCubit(),
  ),
  BlocProvider<PriceLaundryCubit>(
    create: (_) => PriceLaundryCubit(),
  ),
  BlocProvider<UpdatePriceLaundryCubit>(
    create: (_) => UpdatePriceLaundryCubit(),
  ),
  BlocProvider<OrderLaundryCubit>(
    create: (_) => OrderLaundryCubit(),
  )
];
