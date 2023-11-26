import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthsphere/pages/home_page.dart';
import 'package:healthsphere/pages/login_page.dart';
import 'package:healthsphere/pages/main/ai_bot_page.dart';
import 'package:healthsphere/pages/main/hospital_detail_page.dart';
import 'package:healthsphere/pages/register_page.dart';
import 'package:healthsphere/pages/splash_page.dart';
import 'package:healthsphere/values/app_constants.dart';
import 'package:healthsphere/values/app_routes.dart';
import 'package:healthsphere/values/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    authFlowType: AuthFlowType.pkce,
    url: 'https://xnvanbvprtvkbpdeunbc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhudmFuYnZwcnR2a2JwZGV1bmJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAzNzY1MDksImV4cCI6MjAxNTk1MjUwOX0.-JOgzP7mVzCj3-aznPkVvBnh3kFcsFpTa9PNyx1jxlU',
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.loading,
      navigatorKey: AppConstants.navigationKey,
      routes: {
        AppRoutes.loginScreen: (context) => const LoginPage(),
        AppRoutes.loading: (context) => const SplashPage(),
        AppRoutes.registerScreen: (context) => const RegisterPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.bot: (context) => const AIBotScreen(),
        AppRoutes.hospital: (context) => const HospitalDetailsScreen(),
      },
    );
  }
}
