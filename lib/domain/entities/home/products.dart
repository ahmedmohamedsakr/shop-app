class Products {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  String? name;
  String? description;
  List<String?>?images;
  bool? inFavorites;
  bool? inCart;
  Products({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });
}
