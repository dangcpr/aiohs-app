import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/get_price_air_cond/get_price_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/price_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/get_price_cleaning_hourly/get_price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/total_price_CH.dart';
import 'package:rmservice/cleaning_longterm/cubit/get_price/get_price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/order_cleaning_longterm/order_cleaning_longterm_cubit.dart';
import 'package:rmservice/cooking/cubit/get_price_cooking/get_price_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/order_cooking/order_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_cubit.dart';
import 'package:rmservice/history/cubits/get_history_accepted/get_history_accepted_cubit.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_cubit.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_public/get_place_public_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_cubit.dart';
import 'package:rmservice/place_page/cubits/images_place_cubit.dart';
import 'package:rmservice/post_job/cubits/update_post/update_post_cubit.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/shopping/cubits/get_shopping_price/get_shopping_price_cubit.dart';
import 'package:rmservice/shopping/cubits/order_shopping/order_shopping_cubit.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/save_price_shopping.dart';
import 'package:rmservice/shopping/cubits/shopping_price_cubit.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';
import 'package:rmservice/user_address/cubits/get_user_address/get_user_address.dart';
import 'package:rmservice/worker_register/cubits/worker_cubit.dart';
import 'package:rmservice/worker_register/cubits/worker_register/worker_register_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_cubit.dart';

import '../../cleaning_hourly/cubits/save_info/save_info.dart';
import '../../cleaning_longterm/cubit/price_cleaning_longterm_cubit.dart';
import '../../cleaning_longterm/cubit/save_info_cubit.dart';
import '../../cooking/cubit/price_cooking_cubit.dart';
import '../../history/cubits/get_history_cancel/get_history_cancel_cubit.dart';
import '../../history/cubits/order_cancel/order_cancel_cubit.dart';
import '../../post_job/cubits/close_post/close_post_cubit.dart';
import '../../post_job/cubits/get_history_post_cubit/get_history_post_cubit.dart';
import '../../post_job/cubits/get_post_all/get_post_all_cubit.dart';
import '../../post_job/cubits/post_job_cubit/post_job_cubit.dart';
import '../../post_job/cubits/save_info_job_posting.dart';
import '../../profile/cubit/update_profile_cubit.dart';

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

  //Address
  BlocProvider<SaveAddressCubit>(
    create: (_) => SaveAddressCubit(),
  ),

  //Cleaning Hourly
  BlocProvider<SaveInfoCleaningHourlyCubit>(
    create: (_) => SaveInfoCleaningHourlyCubit(),
  ),
  BlocProvider<GetPriceCleaningHourlyCubit>(
    create: (_) => GetPriceCleaningHourlyCubit(),
  ),
  BlocProvider<PriceCleaningHourlyCubit>(
    create: (_) => PriceCleaningHourlyCubit(),
  ),
  BlocProvider<OrderCleaningHourlyCubit>(
    create: (_) => OrderCleaningHourlyCubit(),
  ),
  BlocProvider<CaculatePriceCleaningHourlyCubit>(
    create: (_) => CaculatePriceCleaningHourlyCubit(),
  ),
  BlocProvider<TotalPriceCHCubit>(
    create: (_) => TotalPriceCHCubit(),
  ),

  //Shopping
  BlocProvider<SaveAddressShoppingCubit>(
    create: (_) => SaveAddressShoppingCubit(),
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
  BlocProvider<GetShoppingPriceCubit>(
    create: (_) => GetShoppingPriceCubit(),
  ),
  BlocProvider<ShoppingPriceCubit>(
    create: (_) => ShoppingPriceCubit(),
  ),
  BlocProvider<OrderShoppingCubit>(
    create: (_) => OrderShoppingCubit(),
  ),
  BlocProvider<CalculatePriceShoppingCubit>(
    create: (_) => CalculatePriceShoppingCubit(),
  ),

  // cleaning long-term
  BlocProvider<SaveInfoCleaningLongTermCubit>(
    create: (_) => SaveInfoCleaningLongTermCubit(),
  ),
  BlocProvider<GetPriceCleaningLongtermCubit>(
    create: (_) => GetPriceCleaningLongtermCubit(),
  ),
  BlocProvider<PriceCleaningLongTermCubit>(
    create: (_) => PriceCleaningLongTermCubit(),
  ),
  BlocProvider<OrderCleaningLongtermCubit>(
    create: (_) => OrderCleaningLongtermCubit(),
  ),

  // air conditioning cleaning
  BlocProvider<SaveInfoAirConditioningCleaningCubit>(
    create: (_) => SaveInfoAirConditioningCleaningCubit(),
  ),
  BlocProvider<GetPriceAirCondCubit>(
    create: (_) => GetPriceAirCondCubit(),
  ),
  BlocProvider<AirCondPriceCubit>(
    create: (_) => AirCondPriceCubit(),
  ),
  BlocProvider<OrderAirCondCubit>(
    create: (_) => OrderAirCondCubit(),
  ),

  // cooking
  BlocProvider<SaveInfoCookingCubit>(
    create: (_) => SaveInfoCookingCubit(),
  ),
  BlocProvider<GetPriceCookingCubit>(
    create: (_) => GetPriceCookingCubit(),
  ),
  BlocProvider<CookingPriceCubit>(
    create: (_) => CookingPriceCubit(),
  ),
  BlocProvider<OrderCookingCubit>(
    create: (_) => OrderCookingCubit(),
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
  BlocProvider<OrderLaundryCubit>(
    create: (_) => OrderLaundryCubit(),
  ),
  BlocProvider<CalculateLaundryCubit>(
    create: (_) => CalculateLaundryCubit(),
  ),

  //History
  BlocProvider<GetHistoryOrderCubit>(
    create: (_) => GetHistoryOrderCubit(),
  ),
  BlocProvider<GetHistoryAcceptedCubit>(
    create: (_) => GetHistoryAcceptedCubit(),
  ),
  //History Cancel
  BlocProvider<GetHistoryCancelCubit>(
    create: (_) => GetHistoryCancelCubit(),
  ),
  //Order Cancel
  BlocProvider<OrderCancelCubit>(
    create: (_) => OrderCancelCubit(),
  ),

  //Update profile
  BlocProvider<UpdateProfileCubit>(
    create: (_) => UpdateProfileCubit(),
  ),
  //User Addrss
  BlocProvider<GetUserAddressCubit>(
    create: (_) => GetUserAddressCubit(),
  ),

  //Worker
  BlocProvider<WorkerGetOrderAllCubit>(
    create: (_) => WorkerGetOrderAllCubit(),
  ),

  //Place Page
  BlocProvider<ImagesPlaceCubit>(
    create: (_) => ImagesPlaceCubit(),
  ),
  BlocProvider<GetPlaceUserCubit>(
    create: (_) => GetPlaceUserCubit(),
  ),
  BlocProvider<GetPlacePublicCubit>(
    create: (_) => GetPlacePublicCubit(),
  ),

  // job-posting
  BlocProvider<SaveInfoJobPostingCubit>(
    create: (_) => SaveInfoJobPostingCubit(),
  ),
  BlocProvider<PostJobCubit>(
    create: (_) => PostJobCubit(),
  ),
  BlocProvider<GetHistoryPostCubit>(
    create: (_) => GetHistoryPostCubit(),
  ),
  BlocProvider<UpdatePostCubit>(
    create: (_) => UpdatePostCubit(),
  ),
  BlocProvider<GetPostAllCubit>(
    create: (_) => GetPostAllCubit(),
  ),
  BlocProvider<ClosePostCubit>(
    create: (_) => ClosePostCubit(),
  ),
];
