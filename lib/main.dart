import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/theme/app_theme.dart';
import 'package:zcmc_portal/src/daily_time_record/view/dtr_list.dart'; 

import 'package:zcmc_portal/src/authentication/view/login.dart';
import 'package:zcmc_portal/src/dashboard/view/layout_page.dart';
import 'package:zcmc_portal/src/freewall/view/freewall.dart';
import 'package:zcmc_portal/src/notifications/view/notification.dart';
import 'package:zcmc_portal/src/personal_information/personal_information.dart';
import 'package:zcmc_portal/src/recovery/view/recovery.dart';
import 'package:zcmc_portal/src/schedule/view/schedule.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();  
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
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
    FlutterNativeSplash.remove();
    
    return MaterialApp(
      title: 'ZCMC Portal',
      debugShowCheckedModeBanner: false,  
      theme: appTheme,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const LayoutPage(),
        '/daily-time-record': (context) => const DTRPage(),
        '/personal-information': (context) => const PersonalInformationPage(),
        '/schedule': (context) => const SchedulePage(),
        '/recovery': (context) => const RecoveryPage(),
        '/freewall': (context) => const FreeWallPage(),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}
