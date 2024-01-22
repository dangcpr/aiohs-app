class Inbox {
  late String id;
  late String user_code;
  late String title;
  late String body;
  late String deeplink;
  late bool is_open;
  late String created_at;

  Inbox({
    required this.id,
    required this.user_code,
    required this.title,
    required this.body,
    required this.deeplink,
    required this.is_open,
    required this.created_at
  });

  Inbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_code = json['user_code'];
    title = json['title'];
    body = json['body'];
    deeplink = json['deeplink'];
    is_open = json['is_open'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_code': user_code,
    'title': title,
    'body': body,
    'deeplink': deeplink,
    'is_open': is_open,
    'created_at': created_at
  };
}