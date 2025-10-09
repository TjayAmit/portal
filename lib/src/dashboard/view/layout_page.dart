
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zcmc_portal/core/widgets/avatar/profile_avatar.dart';
import 'package:zcmc_portal/src/daily_time_record/view/dtr_list.dart';
import 'package:zcmc_portal/src/dashboard/view/dashboard_page.dart';
import 'package:zcmc_portal/src/leave_applications/view/leave_application.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ProfileAvatar(),
        // title: Text("ZCMC PORTAL", style: GoogleFonts.pacifico(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 0, 0, 0))),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/personal-information'), 
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/personal-information'), 
            icon: Icon(Icons.chat),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home, size: 20),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_today, color: Colors.white),
            icon: Icon(Icons.calendar_today, size: 20),
            label: 'MY DTR',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.document_scanner, color: Colors.white),
            icon: Icon(Icons.document_scanner, size: 20),
            label: 'Leave',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.document_scanner, color: Colors.white),
            icon: Icon(Icons.announcement), label: 'Announcement')
        ],
      ),
      body: [
        const DashboardPage(),
        const DTRPage(),
        const LeaveApplication(),
        const Text('Anouncements')
      ][currentPageIndex],
    );
  }
}