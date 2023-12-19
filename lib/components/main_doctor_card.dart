import 'package:flutter/material.dart';
import 'package:healthsphere/models/doctor.dart';

class MainDoctorCard extends StatelessWidget {
  final Doctor doctor;

  const MainDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _highlightedText(doctor.name),
            const SizedBox(height: 10),
            Text('Specialty: ${doctor.specialty}'),
            const SizedBox(height: 5),
            Text('Hospital: ${doctor.hospitalName}'),
          ],
        ),
      ),
    );
  }

  Widget _highlightedText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    );
  }
}
