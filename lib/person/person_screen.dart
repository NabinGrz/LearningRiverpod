import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_riverpod/person/notifier.dart';

import 'person_model.dart';

final peopleProvider = ChangeNotifierProvider((_) => DataModel());
final nameController = TextEditingController();
final ageController = TextEditingController();

class PersonScreen extends ConsumerWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Person"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final currentPerson = dataModel.people[index];
              return ListTile(
                title: Text(
                  currentPerson.displayName,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: IconButton(
                    onPressed: () {
                      ref.read(peopleProvider).remove(currentPerson);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                onTap: () async => await addOrUpdateDialog(context,
                        exisitingPerson: currentPerson)
                    .then((value) {
                  if (value != null) dataModel.update(value);
                }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Person? newPerson = await addOrUpdateDialog(context);
          if (newPerson != null) {
            ref.read(peopleProvider).add(newPerson);
          }
        },
      ),
    );
  }
}

Future<Person?> addOrUpdateDialog(BuildContext context,
    {Person? exisitingPerson}) {
  String? name = exisitingPerson?.name;
  int? age = exisitingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';
  return showDialog<Person?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Person"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Enter name here"),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(hintText: "Enter age here"),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (exisitingPerson != null) {
                  Navigator.of(context).pop(exisitingPerson.updated(name, age));
                } else {
                  Navigator.of(context).pop(Person(name: name!, age: age!));
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
