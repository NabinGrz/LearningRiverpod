import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_riverpod/movie/film_screen.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: FilmScreen(),
      ),
    ),
  );
}
