import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/theme/app_theme.dart';
import 'package:zcmc_portal/src/daily_time_record/view/dtr_list.dart'; 

import 'package:zcmc_portal/src/dashboard/view/dashboard_page.dart';
import 'package:zcmc_portal/src/authentication/view/login.dart';
import 'package:zcmc_portal/src/personal_information/personal_information.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    
    return MaterialApp(
      title: 'ZCMC Portal',
      debugShowCheckedModeBanner: false,  
      theme: appTheme,
      home: const LoginPage(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/daily-time-record': (context) => const DTRPage(),
        '/personal-information': (context) => const PersonalInformationPage(),
      },
    );
  }
}
