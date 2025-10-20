import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/database/user_db.dart';
import 'package:zcmc_portal/core/theme/app_theme.dart';
import 'package:zcmc_portal/core/utils/device_authorization_pin_utils.dart';
import 'package:zcmc_portal/src/authentication/view/login_with_pin.dart';
import 'package:zcmc_portal/src/daily_time_record/view/dtr_list.dart'; 

import 'package:zcmc_portal/src/authentication/view/login.dart';
import 'package:zcmc_portal/src/dashboard/view/layout_page.dart';
import 'package:zcmc_portal/src/freewall/view/freewall.dart';
import 'package:zcmc_portal/src/notifications/view/notification.dart';
import 'package:zcmc_portal/src/personal_information/personal_information.dart';
import 'package:zcmc_portal/src/recovery/view/recovery.dart';
import 'package:zcmc_portal/src/schedule/view/schedule.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();  
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await UserDatabase.instance.database;
  
  String authorizationPin =
      await DeviceAuthorizationPinUtils.getAuthorizationPin();
      
  runApp(
    ProviderScope(
      child: MyApp(
        showLogin: authorizationPin == '',
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final bool showLogin;
  
  const MyApp({super.key, required this.showLogin});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    FlutterNativeSplash.remove();
    
    return MaterialApp(
      title: 'ZCMC Portal',
      debugShowCheckedModeBanner: false,  
      theme: appTheme,
      home: showLogin ? const LoginPage() : const LoginWithPin(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/login-with-pin': (context) => const LoginWithPin(),
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
