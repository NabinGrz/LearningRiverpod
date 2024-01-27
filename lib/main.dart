import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_riverpod/login.dart';
import 'package:learning_riverpod/person/person_screen.dart';

import 'learning2.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: PersonScreen(),
      ),
    ),
  );
}
