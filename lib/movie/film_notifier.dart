import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'film_model.dart';

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(allFilms);

  void update({required Film film, required bool isFavourite}) {
    state = state
        .map((thisFilm) =>
            thisFilm.id == film.id ? thisFilm.copy(isFavourite) : thisFilm)
        .toList();
  }
}

List<Film> allFilms = [
  Film(
      id: "1",
      isFavourite: false,
      name: "Venom",
      description: "Description for Venom"),
  Film(
      id: "2",
      isFavourite: false,
      name: "Rebel Moon",
      description: "Description for Rebel Moon"),
  Film(
      id: "3",
      isFavourite: false,
      name: "Evil Dead Rise",
      description: "Description for Evil Dead Rise"),
  Film(
      id: "4",
      isFavourite: false,
      name: "Mortal Engines",
      description: "Description for Mortal Engines"),
  Film(
      id: "5",
      isFavourite: false,
      name: "The Nun",
      description: "Description for The Nun"),
];
