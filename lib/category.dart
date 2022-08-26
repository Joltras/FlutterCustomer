
class Category {

  String name;
  String abbreviation;

  Category({
    required this.name,
    required this.abbreviation
  });

  factory Category.fromMap(Map taskMap) {
    return Category(
      name: taskMap['name'],
      abbreviation: taskMap['abbreviation'],
    );
  }

}