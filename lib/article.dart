
class Article {

  int id;
  String name;
  String description;
  double price;

  Article({
    required this.id,
    required this.name,
    required this.description,
    required this.price
  });

  factory Article.fromMap(Map taskMap) {
    return Article(
      id: taskMap['id'],
      name: taskMap['name'],
      description: taskMap['description'],
      price: taskMap['price'],
    );
  }


}