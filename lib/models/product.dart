class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'id':int id,
        'name':String name,
        'description':String description,
        'price':double price,
        'quantity':int quantity,
        'imageUrl':String imageUrl,
    } => Product(id: id,name: name,description: description,price: price,quantity: quantity,imageUrl: imageUrl), _=>throw const FormatException('Failed to load product'),
    };
  }
}
