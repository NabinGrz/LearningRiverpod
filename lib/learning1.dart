import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, int>((ref) => Counter());
final userNameProvider =
    StateNotifierProvider<Username, String?>((ref) => Username());
final toggleProvider = StateNotifierProvider<Toggle, bool>((ref) => Toggle());

class Learning1 extends ConsumerWidget {
  const Learning1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final value = ref.watch(counterProvider);
                return Text(
                  "$value",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ); // Hello world
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final value = ref.watch(userNameProvider);
                return Text(
                  value ?? "Enter username",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ); // Hello world
              },
            ),
            TextField(
              onChanged: ref.read(userNameProvider.notifier).onChanged,
            ),
            ElevatedButton(
                onPressed: ref.read(counterProvider.notifier).increment,
                child: const Icon(Icons.add)),
            ElevatedButton(
                onPressed: ref.read(counterProvider.notifier).decrement,
                child: const Icon(Icons.remove)),
            ElevatedButton(
                onPressed: ref.read(counterProvider.notifier).reset,
                child: const Icon(Icons.restore)),
            Consumer(builder: (context, ref, child) {
              return Switch.adaptive(
                  value: ref.watch(toggleProvider),
                  onChanged: ref.read(toggleProvider.notifier).toggle);
            })
          ],
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state = state + 1;

  void decrement() => state = state == 0 ? state : state - 1;
  void reset() => state = 0;
}

class Username extends StateNotifier<String?> {
  Username() : super(null);
  void onChanged(String username) => state = username;
}

class Toggle extends StateNotifier<bool> {
  Toggle() : super(false);
  void toggle(bool val) => state = val;
}
