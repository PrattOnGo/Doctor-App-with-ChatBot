import 'package:flutter/material.dart';
import 'package:healthsphere/main.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          ElevatedButton(
            onPressed: () async {
              await supabase.auth.signOut();
              AppRoutes.loading.pushName();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
