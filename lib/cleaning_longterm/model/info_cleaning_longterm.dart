class InfoCleaningLongterm {
  InfoCleaningLongterm({
    required this.durationWork,
    required this.numberOfMaid,
    required this.datesOfWork,
    required this.timeToWork,
    required this.monthsOfWork,
    required this.notes,
  });
  late final DurationWork durationWork;
  late final int numberOfMaid;
  late final List<String> datesOfWork;
  late final String timeToWork;
  late final String monthsOfWork;
  late final String notes;

  InfoCleaningLongterm.fromJson(Map<String, dynamic> json) {
    durationWork = DurationWork.fromJson(json['durationWork']);
    numberOfMaid = json['numberOfMaid'];
    datesOfWork = json['datesOfWork'];
    timeToWork = json['timeToWork'];
    monthsOfWork = json['monthsOfWork'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['durationWork'] = durationWork.toJson();
    _data['numberOfMaid'] = numberOfMaid;
    _data['datesOfWork'] = datesOfWork;
    _data['timeToWork'] = timeToWork;
    _data['monthsOfWork'] = monthsOfWork;
    _data['notes'] = notes;
    return _data;
  }
}

class DurationWork {
  DurationWork({
    required this.time,
    required this.square,
    required this.numberOfRoom,
  });
  late final String time;
  late final String square;
  late final String numberOfRoom;

  DurationWork.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    square = json['square'];
    numberOfRoom = json['numberOfRoom'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['square'] = square;
    _data['numberOfRoom'] = numberOfRoom;
    return _data;
  }
}
