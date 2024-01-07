import 'package:flutter/material.dart';
import 'package:healthsphere/components/doctor_card_with_edit_button.dart';
import 'package:healthsphere/components/hospital_card_edit.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/models/doctor.dart';
import 'package:healthsphere/models/hospital.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String role = "user";
  Doctor? d;
  Hospital? h;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    String tempRole = 'user';
    try {
      final res = await supabase.from("profile").select().limit(1).single();
      tempRole = res['role'];
      setState(() {
        role = res['role'];
      });
    } catch (e) {}

    if (tempRole == "admin") {
      final res = await supabase
          .from("hospitals")
          .select()
          .eq("admin", supabase.auth.currentUser?.id)
          .limit(1)
          .single();
      setState(() {
        h = Hospital.fromMap(res);
      });
    } else if (tempRole == "doctor") {
      final res = await supabase
          .from("doctors")
          .select()
          .eq("user_id", supabase.auth.currentUser?.id)
          .limit(1)
          .single();
      setState(() {
        d = Doctor.fromMap(res);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              "Settings",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          role == 'admin' && h != null
              ? HospitalCardEdit(
                  data: h!,
                  callback2: (hos) {
                    AppRoutes.bloodEdit.pushName(data: hos);
                  },
                  callback: (hos) async {
                    var res = await AppRoutes.hospitalEdit.pushName(data: hos)
                        as Hospital;
                    if (mounted) {
                      setState(() {
                        h = res;
                      });
                    }
                  })
              : role == 'doctor' && d != null
                  ? DoctorCardWithEdit(
                      data: d!,
                    )
                  : Container(),
          ElevatedButton(
            onPressed: () async {
              await supabase.auth.signOut();
              AppRoutes.loading.pushName();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
