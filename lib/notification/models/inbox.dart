class Inbox {
  late String id;
  late String user_id;
  late String title;
  late String body;
  late String deeplink;
  late bool is_open;
  late String created_at;

  Inbox({
    required this.id,
    required this.user_id,
    required this.title,
    required this.body,
    required this.deeplink,
    required this.is_open,
    required this.created_at
  });

  Inbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    title = json['title'];
    body = json['body'];
    deeplink = json['deeplink'];
    is_open = json['is_open'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': user_id,
    'title': title,
    'body': body,
    'deeplink': deeplink,
    'is_open': is_open,
    'created_at': created_at
  };
}