import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cleaning_hourly/constants/vaccum_icons_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/cleaning_hourly/cubits/price_cleaning_hourly_cubit.dart';

class DurationClass {
  late int? duration;
  late int? area;
  late int? numOfRoom;

  DurationClass({
    this.duration,
    this.area,
    this.numOfRoom,
  });

  DurationClass.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    area = json['area'];
    numOfRoom = json['numOfRoom'];
  }

  Map<String, dynamic> toJson() =>
      {'duration': duration, 'area': area, 'numOfRoom': numOfRoom};
}

final listDuration = [
  DurationClass(
    duration: 2,
    area: 55,
    numOfRoom: 2,
  ),
  DurationClass(
    duration: 3,
    area: 85,
    numOfRoom: 3,
  ),
  DurationClass(
    duration: 4,
    area: 105,
    numOfRoom: 4,
  ),
];

class AddServiceClass {
  late int? idService;
  late IconData icon;
  late String? name;
  late String? action;
  late String? tooltip;

  AddServiceClass({
    this.idService,
    required this.icon,
    this.name,
    this.action,
    this.tooltip = "",
  });

  AddServiceClass.fromJson(Map<String, dynamic> json) {
    idService = json['idService'];
    icon = json['icon'];
    name = json['name'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() =>
      {'idService': idService, 'icon': icon, 'name': name, 'action': action};
}
NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');
List<AddServiceClass> getListAddService(BuildContext context) {
  return [
    AddServiceClass(
      idService: 0,
      icon: Icons.dining_outlined,
      name: AppLocalizations.of(context)!.cookingLabel,
      action: '+ 1 ${AppLocalizations.of(context)!.hourWorkingLabel}',
      tooltip: "Bạn có thể yêu cầu người giúp việc nấu ăn nếu thời gian của bạn không cho phép."
    ),
    AddServiceClass(
      idService: 1,
      icon: Icons.iron,
      name: AppLocalizations.of(context)!.ironLabel,
      action: '+ 1 ${AppLocalizations.of(context)!.hourWorkingLabel}',
      tooltip: "Người giúp việc sẽ sử dụng bàn ủi của bạn để ủi đồ (nếu bạn không sử dụng dịch vụ \"Mang theo dụng cụ\")."
    ),
    AddServiceClass(
      idService: 2,
      icon: Icons.cleaning_services,
      name: AppLocalizations.of(context)!.bringToolLabel,
      action: '+ ' + numberFormat.format(context.read<PriceCleaningHourlyCubit>().state.bringTools),
      tooltip: "Nếu nhà bạn không có dụng cụ để làm việc thì bạn có thể đặt thêm dịch vụ \"Mang theo dụng cụ\", nếu không thì người giúp việc sẽ sử dụng của nhà bạn.\n\n" +
       "Bạn có thể ghi lại những dụng cụ cần ở mục \"Ghi chú cho người giúp việc\" ở bước sau."
    ),
    AddServiceClass(
      idService: 3,
      icon: VaccumIcons.noun_vacuum_4936787,
      name: AppLocalizations.of(context)!.bringVaccumLabel,
      action: '+ 20.000 VNĐ',
    )
  ];
}