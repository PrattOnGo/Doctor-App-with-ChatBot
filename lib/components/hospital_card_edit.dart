import 'package:flutter/material.dart';
import 'package:healthsphere/models/hospital.dart';

class HospitalCardEdit extends StatelessWidget {
  const HospitalCardEdit(
      {super.key, required this.data, required this.callback});

  final Hospital data;
  final void Function(Hospital data) callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),
                  data.website != null
                      ? Text(
                          "Website : ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : Container(),
                  data.website != null
                      ? Text(
                          data.website!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : Container(),
                  const SizedBox(height: 15),
                  TextButton.icon(
                    icon: const Icon(Icons.edit),
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        )),
                    onPressed: () => callback(data),
                    label: const Text("Edit"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
