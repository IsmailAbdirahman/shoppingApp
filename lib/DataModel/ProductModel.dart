class ProductModel {
  final String? productPrice;
  final String?  productImage;
  final String?  productName;
  final String?  productDescription;
  bool?  isDelivered = false;
  final String?  men;
  final String?  women;
  final List<String>?  avSize;

  ProductModel(
      {this.productPrice,
      this.productImage,
      this.isDelivered,
      this.men,
      this.women,
      this.productName,
      this.avSize,
      this.productDescription});



}
