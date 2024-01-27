import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City { kathmandu, lamjung, pokhara, butwal }

final currentCityProvider = StateProvider<City?>((ref) => null);

Future<String> getWeather(City city) async {
  final url =
      "https://api.openweathermap.org/data/2.5/weather?q=${city.name}&APPID=43ea6baaad7663dc17637e22ee6f78f2";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    var minTemp = data['main']['temp'];
    return "${minTemp - 273.15}°C";
  } else {
    return "";
  }
}

final weatherProvider = FutureProvider<String>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    final value = getWeather(city);
    return value;
  } else {
    return "Unknown city!!";
  }
});

class Learning2 extends ConsumerWidget {
  const Learning2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            weather.when(
                data: (data) {
                  return Text(
                    data.toUpperCase(),
                    style: const TextStyle(fontSize: 50),
                  );
                },
                error: (_, __) => const Text("Unknown City!!!"),
                loading: () => const CircularProgressIndicator()),
            ListView.builder(
              shrinkWrap: true,
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final selectedCity = City.values[index];
                final isSelected =
                    selectedCity == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(selectedCity.name),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () => ref.read(currentCityProvider.notifier).state =
                      selectedCity,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
