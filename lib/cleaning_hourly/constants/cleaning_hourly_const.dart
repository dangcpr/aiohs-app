import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/constants/vaccum_icons_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  AddServiceClass({
    this.idService,
    required this.icon,
    this.name,
    this.action,
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

List<AddServiceClass> getListAddService(BuildContext context) {
  return [
    AddServiceClass(
      idService: 0,
      icon: Icons.dining_outlined,
      name: AppLocalizations.of(context)!.cookingLabel,
      action: '+ 1 ${AppLocalizations.of(context)!.hourWorkingLabel}',
    ),
    AddServiceClass(
      idService: 1,
      icon: Icons.iron,
      name: AppLocalizations.of(context)!.ironLabel,
      action: '+ 1 ${AppLocalizations.of(context)!.hourWorkingLabel}',
    ),
    AddServiceClass(
      idService: 2,
      icon: Icons.cleaning_services,
      name: AppLocalizations.of(context)!.bringToolLabel,
      action: '+ 30.000 VNĐ',
    ),
    AddServiceClass(
      idService: 3,
      icon: VaccumIcons.noun_vacuum_4936787,
      name: AppLocalizations.of(context)!.bringVaccumLabel,
      action: '+ 20.000 VNĐ',
    )
  ];
}