import 'package:flutter/material.dart';
import 'package:healthsphere/models/blood.dart';
import 'package:healthsphere/models/hospital.dart';

class BloodCard extends StatelessWidget {
  final Blood blood;
  final void Function(Hospital data) callback;

  const BloodCard({super.key, required this.blood, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(blood.hospitalName),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${blood.amount} units',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Hospital : '),
                  Text(
                    blood.hospitalName.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
