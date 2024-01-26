class ChatInfo {
  late String room_id;
  late String post_code;
  late String post_name;
  late String requester;
  late String receiver;

  ChatInfo({
    required this.room_id,
    required this.post_code,
    required this.post_name,
    required this.requester,
    required this.receiver,
  });

  ChatInfo.fromJson(Map<String, dynamic> json) {
    room_id = json['room_id'];
    post_code = json['post_code'];
    post_name = json['post_name'];
    requester = json['requester'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() => {
        'room_id': room_id,
        'post_code': post_code,
        'post_name': post_name,
        'requester': requester,
        'receiver': receiver,
      };
}
