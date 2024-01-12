class ProductBuyRequest {
  final String item;
  final List<String> images;

  ProductBuyRequest({required this.item, required this.images});

  ProductBuyRequest.fromJson(Map<String, dynamic> json)
      : item = json['item'],
        images = json['images'].cast<String>();

  Map<String, dynamic> toJson() => {
        'item': item,
        'images': images,
      };
}
