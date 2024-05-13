// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/blood.dart';
import 'package:healthsphere/models/hospital.dart';

class BloodGroupEditPage extends StatefulWidget {
  const BloodGroupEditPage({super.key});

  @override
  State<BloodGroupEditPage> createState() => _BloodGroupEditPageState();
}

class _BloodGroupEditPageState extends State<BloodGroupEditPage> {
  bool _isLoading = false;

  TextEditingController A_pos = TextEditingController();
  TextEditingController A_neg = TextEditingController();
  TextEditingController AB_pos = TextEditingController();
  TextEditingController AB_neg = TextEditingController();
  TextEditingController B_pos = TextEditingController();
  TextEditingController B_neg = TextEditingController();
  TextEditingController O_neg = TextEditingController();
  TextEditingController O_pos = TextEditingController();

  List<Blood> data = [];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), init);
    super.initState();
  }

  void init() async {
    try {
      final d2 = ModalRoute.of(context)!.settings.arguments as Hospital;
      final d =
          await supabase.from("blood").select().eq("hospital", d2.id) as List;

      List<Blood> t = [];

      for (var blood in d) {
        blood.addAll({"hospitalName": d2});

        t.add(Blood.fromMap(blood));
      }

      A_pos.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "A+",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      A_neg.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "A-",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      AB_pos.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "AB+",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      AB_neg.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "AB-",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());

      B_pos.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "B+",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      B_neg.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "B-",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      O_pos.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "O+",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());
      O_neg.value = TextEditingValue(
          text: t
              .firstWhere((element) => element.bloodGroup == "O-",
                  orElse: () => t.first.copyWith(amount: 0))
              .amount
              .toString());

      setState(() {
        data.addAll(t);
      });
    } catch (e) {
      print(e);
    }
  }

  void save(String group, String value) async {
    final index = data.indexWhere((element) => element.bloodGroup == group);
    final d2 = ModalRoute.of(context)!.settings.arguments as Hospital;

    if (index != -1) {
      final ele = data[index];
      await supabase
          .from("blood")
          .update({'amount': int.tryParse(value) ?? 0})
          .eq("id", ele.id)
          .select();
    } else {
      final b = Blood(
          id: 0,
          bloodGroup: group,
          amount: int.tryParse(value) ?? 0,
          hospital: d2.id,
          hospitalName: d2);
      await supabase.from("blood").insert([b.toMapSpecial()]);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Blood avaliblity"),
          ),
          body: const Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Blood avaliblity"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextField(
                keyboardType: TextInputType.number,
                controller: A_pos,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "A+",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("A+", A_pos.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: A_neg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "A-",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("A-", A_neg.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: AB_pos,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "AB+",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("AB+", AB_pos.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: AB_neg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "AB-",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("AB-", AB_neg.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: B_pos,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "B+",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("B+", B_pos.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: B_neg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "B-",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("B-", B_neg.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: O_pos,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "O+",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("O+", O_pos.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.number,
                controller: O_neg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "O-",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            save("O+", O_neg.text);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).highlightColor),
                          child: const Text("Save")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
