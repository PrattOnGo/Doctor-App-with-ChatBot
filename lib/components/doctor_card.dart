import 'package:flutter/material.dart';
import 'package:healthsphere/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.data});

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
              RichText(
                text: TextSpan(
                  text: "Availability : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: "\n${data.availability}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
