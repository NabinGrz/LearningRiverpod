import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_riverpod/movie/film_notifier.dart';
import 'package:learning_riverpod/movie/films_widget.dart';

import 'film_model.dart';

enum FavouriteStatus { all, favourite, nonFavourite }

final favouriteStatusProvider = StateProvider((ref) => FavouriteStatus.all);

final allFilmProvider =
    StateNotifierProvider<FilmNotifier, List<Film>>((_) => FilmNotifier());

final favouriteFilmProvider = Provider((ref) {
  final films = ref.watch(allFilmProvider);
  return films.where((element) => element.isFavourite);
});
final notfavouriteFilmProvider = Provider((ref) {
  final films = ref.watch(allFilmProvider);
  return films.where((element) => !element.isFavourite);
});

class FilmScreen extends StatelessWidget {
  const FilmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Films"),
      ),
      body: Column(
        children: [
          const FavouriteWidget(),
          Consumer(
            builder: (context, ref, child) {
              print("Build");
              switch (ref.watch(favouriteStatusProvider)) {
                case FavouriteStatus.all:
                  return FilmsList(provider: allFilmProvider);
                case FavouriteStatus.favourite:
                  return FilmsList(provider: favouriteFilmProvider);
                case FavouriteStatus.nonFavourite:
                  return FilmsList(provider: notfavouriteFilmProvider);
                default:
              }
              return FilmsList(provider: allFilmProvider);
            },
          ),
        ],
      ),
    );
  }
}

class FavouriteWidget extends ConsumerWidget {
  const FavouriteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final value = ref.watch(favouriteStatusProvider).name;
        final items = FavouriteStatus.values
            .map((status) => InkWell(
                  onTap: () {
                    ref.read(favouriteStatusProvider.notifier).state = status;
                  },
                  child: Text(
                    status.name,
                    style: TextStyle(
                        color: value == status.name ? Colors.blue : null),
                  ),
                ))
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ); // return DropdownButton(
      },
    );
  }
}
