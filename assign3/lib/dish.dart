class Dish {
  final String name;
  final double price;
  bool isAdded;

  Dish({
    required this.name,
    required this.price,
    this.isAdded = false,
  });
}
