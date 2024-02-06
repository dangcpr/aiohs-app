class Zalopay {
  late String ref_id;
  late String payment_url;

  Zalopay({this.ref_id = "0", this.payment_url = ""});

  Zalopay.fromJson(Map<String, dynamic> json) {
    ref_id = json['ref_id'];
    payment_url = json['payment_url'];
  }

  Map<String, dynamic> toJson() => {
        'ref_id': ref_id,
        'payment_url': payment_url,
      };
}
