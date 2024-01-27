import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_riverpod/movie/film_screen.dart';

import 'film_model.dart';

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider).toList();
    return Expanded(
        child: ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        final currentFilm = films[index];
        final favouriteIcon = currentFilm.isFavourite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline);
        return ListTile(
          title: Text(currentFilm.name),
          subtitle: Text(currentFilm.description),
          trailing: favouriteIcon,
          onTap: () {
            ref.read(allFilmProvider.notifier).update(
                film: currentFilm, isFavourite: !currentFilm.isFavourite);
          },
        );
      },
    ));
  }
}
