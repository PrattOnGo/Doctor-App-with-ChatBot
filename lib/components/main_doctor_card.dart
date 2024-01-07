import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/doctor.dart';

class MainDoctorCard extends StatelessWidget {
  final Doctor doctor;

  const MainDoctorCard({super.key, required this.doctor});

  void save(BuildContext context) async {
    final res = await supabase
        .from('appointments')
        .select()
        .eq("user_id", supabase.auth.currentUser!.id)
        .limit(1)
        .single();

    if (res != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have already booked an appointment'),
        ));
      }
      return;
    }

    await supabase.from('appointments').insert(
        {"doctor": doctor.id, "user_id": supabase.auth.currentUser!.id});
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully booked'),
      ));
    }
  }

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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () => save(context),
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.grey)),
                        child: const Text("Book Appointment")),
                  ),
                ],
              ),
            ),
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
