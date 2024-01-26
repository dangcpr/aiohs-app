class ChatDetail {
  late String roomId;
  late String sender;
  late String receiver;
  late String content;
  late String sendTime;

  ChatDetail({
    required this.roomId,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.sendTime,
  });

  ChatDetail.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    sender = json['sender'];
    receiver = json['receiver'];
    content = json['content'];
    sendTime = json['send_time'];
  }

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'sender': sender,
        'receiver': receiver,
        'content': content,
        'send_time': sendTime,
      };
}

class ChatDetailResult {
  late String next;
  late List<ChatDetail> result;

  ChatDetailResult({
    required this.next,
    required this.result,
  });

  ChatDetailResult.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    result = [];
    for (var item in json['result']) {
      result.add(ChatDetail.fromJson(item));
    }
  }

  Map<String, dynamic> toJson() => {
        'next': next,
        'result': result,
      };
}