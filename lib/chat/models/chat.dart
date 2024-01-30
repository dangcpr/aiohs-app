class ChatInfo {
  ChatInfo({
    required this.roomId,
    required this.postCode,
    required this.postName,
    required this.requester,
    required this.receiver,
    required this.lastMessage,
    required this.key,
  });
  late final String roomId;
  late final String postCode;
  late final String postName;
  late final String requester;
  late final String receiver;
  late final String lastMessage;
  late final String key;

  ChatInfo.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    postCode = json['post_code'];
    postName = json['post_name'];
    requester = json['requester'];
    receiver = json['receiver'];
    lastMessage = json['last_message'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['room_id'] = roomId;
    _data['post_code'] = postCode;
    _data['post_name'] = postName;
    _data['requester'] = requester;
    _data['receiver'] = receiver;
    _data['last_message'] = lastMessage;
    _data['key'] = key;
    return _data;
  }
}
