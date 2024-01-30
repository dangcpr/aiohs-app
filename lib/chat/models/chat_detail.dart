class Messages {
  Messages({
    required this.roomId,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.sendTime,
  });
  late final String roomId;
  late final String sender;
  late final String receiver;
  late final String content;
  late final String sendTime;

  Messages.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    sender = json['sender'];
    receiver = json['receiver'];
    content = json['content'];
    sendTime = json['send_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['room_id'] = roomId;
    _data['sender'] = sender;
    _data['receiver'] = receiver;
    _data['content'] = content;
    _data['send_time'] = sendTime;
    return _data;
  }
}

class ChatDetailResult {
  late int next;
  late List<Messages> result;

  ChatDetailResult({
    required this.next,
    required this.result,
  });

  ChatDetailResult.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    result = [];
    for (var item in json['messages']) {
      result.add(Messages.fromJson(item));
    }
  }

  Map<String, dynamic> toJson() => {
        'next': next,
        'result': result,
      };
}
