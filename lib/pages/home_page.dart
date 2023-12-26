import 'package:flutter/material.dart';
import 'package:healthsphere/pages/main/blood_group_page.dart';
import 'package:healthsphere/pages/main/doctors_page.dart';
import 'package:healthsphere/pages/main/hostital_page.dart';
import 'package:healthsphere/pages/main/settings_page.dart';
import 'package:healthsphere/utils/extensions.dart';
import 'package:healthsphere/values/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HospitalPage(),
    Text(
      '',
    ),
    DoctorPage(),
    BloodGroupPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      AppRoutes.bot.pushName();
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital_outlined),
                label: 'Hospitals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant_rounded),
                label: 'Assistant',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.personal_injury_rounded),
                label: 'Doctors',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bloodtype),
                label: 'Blood availability',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            unselectedItemColor: Colors.grey,
          )),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   // void _getAccount() async {
//   //   final id = supabase.auth.currentUser?.id;

//   // }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text("Welcome")),
//     );
//   }
// }
