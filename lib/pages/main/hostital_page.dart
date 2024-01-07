import 'package:flutter/material.dart';
import 'package:healthsphere/components/hospital_card.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/hospital.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void onClick(Hospital data) {
    AppRoutes.hospital.pushName(data: data);
  }

  void getData() async {
    if (supabase.auth.currentUser == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final res = await supabase.from("hospitals").select() as List;
    List<Hospital> temp = [];
    for (var ele in res) {
      temp.add(Hospital(
        address: ele['address'],
        description: ele['description'],
        id: ele["id"] as int,
        location: ele['location'],
        name: ele['name'],
        website: ele['website'],
      ));
    }
    setState(() {
      data.addAll(temp);
      isLoading = false;
    });
  }

  bool isLoading = true;
  List<Hospital> data = [];
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top * 0.2,
        right: 10,
        left: 10,
      ),
      child: ListView.builder(
        itemCount: data.length + 1,
        itemBuilder: (context, index) => index == 0
            ? Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "Hospitals",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            : HospitalCard(
                data: data[index - 1],
                callback: onClick,
              ),
      ),
    );
  }
}
