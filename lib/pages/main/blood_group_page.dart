import 'package:flutter/material.dart';
import 'package:healthsphere/components/blood_card.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/blood.dart';
import 'package:healthsphere/models/hospital.dart';
import 'package:healthsphere/utils/extensions.dart';

import '../../values/app_routes.dart';

class BloodGroupPage extends StatefulWidget {
  const BloodGroupPage({super.key});

  @override
  State<BloodGroupPage> createState() => _BloodGroupPageState();
}

class _BloodGroupPageState extends State<BloodGroupPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (supabase.auth.currentUser == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final res = await supabase.from("blood").select() as List;
    final res2 = await supabase.from("hospitals").select() as List;

    List<Blood> temp = [];
    List<Hospital> hospital = [];

    for (var ele in res2) {
      hospital.add(Hospital.fromMap(ele));
    }

    for (var ele in res) {
      final tt =
          hospital.firstWhere((element) => element.id == ele['hospital']);
      ele.addAll({"hospitalName": tt});
      temp.add(Blood.fromMap(ele));
    }
    temp.sort((a, b) => a.bloodGroup.compareTo(b.bloodGroup));

    setState(() {
      data.addAll(temp);
      isLoading = false;
    });
  }

  bool isLoading = true;
  List<Blood> data = [];

  void onClick(Hospital data) {
    AppRoutes.hospital.pushName(data: data);
  }

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
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Blood Availability",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.bloodtype_outlined),
                        const SizedBox(width: 5),
                        Text(
                          data[index].bloodGroup,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  BloodCard(
                    blood: data[index],
                    callback: onClick,
                  ),
                ],
              );
            }
            if (data[index - 1].bloodGroup != data[index].bloodGroup) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.bloodtype_outlined),
                        const SizedBox(width: 5),
                        Text(
                          data[index].bloodGroup,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  BloodCard(
                    blood: data[index],
                    callback: onClick,
                  ),
                ],
              );
            }
            return BloodCard(
              blood: data[index],
              callback: onClick,
            );
          }),
    );
  }
}
