import 'package:flutter/material.dart';
import 'package:healthsphere/models/doctor.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class DoctorCardWithEdit extends StatelessWidget {
  const DoctorCardWithEdit({super.key, required this.data});

  final Doctor data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Doctor Name : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: data.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Specialty : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: data.specialty,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.edit),
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        )),
                    onPressed: () => {AppRoutes.profile.pushName(data: data)},
                    label: const Text("Profile"),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.edit),
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        )),
                    onPressed: () => {},
                    label: const Text("Appointment"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
