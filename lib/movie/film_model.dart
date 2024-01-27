class Film {
  final String id;
  final bool isFavourite;
  final String name;
  final String description;

  Film(
      {required this.id,
      required this.isFavourite,
      required this.name,
      required this.description});

  Film copy(bool isFavourite) => Film(
      id: id, isFavourite: isFavourite, name: name, description: description);
}
