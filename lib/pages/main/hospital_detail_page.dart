import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/doctor.dart';
import 'package:healthsphere/models/hospital.dart';

class HospitalDetailsScreen extends StatefulWidget {
  const HospitalDetailsScreen({super.key});

  @override
  State<HospitalDetailsScreen> createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  List<Doctor> doctors = [];
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _getData(ModalRoute.of(context)!.settings.arguments as Hospital);
    });
    super.initState();
  }

  void _getData(Hospital data) async {
    final res =
        await supabase.from("doctors").select().eq("hospital", data.id) as List;
    List<Doctor> temp = [];
    for (var ele in res) {
      temp.add(Doctor.fromMap(ele));
    }
    setState(() {
      doctors.addAll(temp);
      _isLoading = false;
    });
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
        title: Text(data.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Hospital Name : ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: data.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Website : ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: data.website ?? "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Address : ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: data.address,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "About : ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: data.description,
                              style: Theme.of(context).textTheme.bodyLarge!,
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
