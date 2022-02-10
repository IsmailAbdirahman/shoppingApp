class OrderedModel {
  final String? orderedImage;
  final String? orderedPrice;
  final String? quantity;
  final bool? isDelivered;
  final String? nameOfShoe;
  final String? sizeOfShoe;
  final String? orderedDate;

//constructor
  OrderedModel(
      {this.orderedImage,
      this.orderedPrice,
      this.quantity,
      this.isDelivered,
      this.nameOfShoe,
      this.orderedDate,
      this.sizeOfShoe});
}
