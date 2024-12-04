class EditProductModel {
  final String? title;
  final String? category;
  final String? price;
  final String? quantity;
  final String? quantityType;
  final String? weight;
  final String? description;
  final String? image;
  final String? docId;
  final bool? isEdit;

  EditProductModel({
    this.title,
    this.category,
    this.price,
    this.quantity,
    this.quantityType,
    this.weight,
    this.description,
    this.image,
    this.docId,
    this.isEdit,
  });

  // Optional: Add a factory constructor for creating a Product from a JSON map
  factory EditProductModel.fromJson(Map<String, dynamic> json) {
    return EditProductModel(
      title: json['title'] as String,
      category: json['category'] as String,
      price: json['price'] as String,
      quantity: json['quantity'] as String,
      quantityType: json['quantityType'] as String,
      weight: json['weight'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      docId: json['docId'] as String,
      isEdit: json['isEdit'] as bool,
    );
  }

  // Optional: Add a method for converting a Product instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'price': price,
      'quantity': quantity,
      'quantityType': quantityType,
      'weight': weight,
      'description': description,
      'image': image,
      'docId': docId,
      'isEdit': isEdit,
    };
  }
}
