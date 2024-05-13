import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/hospital.dart';

class HospitalEditScreen extends StatefulWidget {
  const HospitalEditScreen({super.key});

  @override
  State<HospitalEditScreen> createState() => _HospitalEditScreenState();
}

class _HospitalEditScreenState extends State<HospitalEditScreen> {
  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final data = ModalRoute.of(context)!.settings.arguments as Hospital;
      nameController.value = TextEditingValue(text: data.name);
      websiteController.value = TextEditingValue(text: data.website ?? "");
      locationController.value = TextEditingValue(text: data.location);
      addressController.value = TextEditingValue(text: data.address);
      descriptionController.value = TextEditingValue(text: data.description);
    });
    super.initState();
  }

  void _update(Hospital h) async {
    if (nameController.text.isNotEmpty &&
        websiteController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      Hospital d = h.copyWith(
        address: websiteController.text,
        name: nameController.text,
        website: websiteController.text,
        description: descriptionController.text,
        location: locationController.text,
      );
      setState(() {
        _isLoading = true;
      });

      try {
        await supabase.from("hospitals").update(d.toMap()).eq("id", h.id);
      } catch (e) {}

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
    final data = ModalRoute.of(context)!.settings.arguments as Hospital;
    if (_isLoading) {
      return Scaffold(
          appBar: AppBar(
            title: Text(data.name),
          ),
          body: const Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Hospital"),
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
                controller: websiteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Website",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                minLines: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: addressController,
                maxLines: 5,
                minLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Location",
                ),
              ),
              const SizedBox(height: 25),
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
