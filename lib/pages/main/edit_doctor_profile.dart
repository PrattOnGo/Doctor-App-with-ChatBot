import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/doctor.dart';

class DoctorEditScreen extends StatefulWidget {
  const DoctorEditScreen({super.key});

  @override
  State<DoctorEditScreen> createState() => _DoctorEditScreenState();
}

class _DoctorEditScreenState extends State<DoctorEditScreen> {
  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  TextEditingController avaliblityController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final data = ModalRoute.of(context)!.settings.arguments as Doctor;
      nameController.value = TextEditingValue(text: data.name);
      specialtyController.value = TextEditingValue(text: data.specialty);
      avaliblityController.value =
          TextEditingValue(text: data.availability.toString());
    });
    super.initState();
  }

  void _update(Doctor h) async {
    if (nameController.text.isNotEmpty &&
        specialtyController.text.isNotEmpty &&
        avaliblityController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      Doctor d = h.copyWith(
        name: nameController.text,
        availability: avaliblityController.text,
        specialty: specialtyController.text,
      );
      setState(() {
        _isLoading = true;
      });

      try {
        await supabase.from("doctors").update(d.toMap()).eq("id", h.id);
      } catch (e) {
        print(e);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Navigator.pop(context, d);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Doctor;
    if (_isLoading) {
      return Scaffold(
          appBar: AppBar(
            title: Text(data.name),
          ),
          body: const Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: specialtyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Specialty",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: avaliblityController,
                maxLines: 4,
                minLines: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Avaliblity",
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            _update(data);
                          },
                          child: const Text("Save")))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
