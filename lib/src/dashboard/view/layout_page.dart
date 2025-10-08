
import 'package:flutter/material.dart';
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
        title: Text("ZCMC PORTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Poppins'),),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_today, color: Colors.white),
            icon: Badge(label: Text('2'), child: Icon(Icons.calendar_today)),
            label: 'MY DTR',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.document_scanner, color: Colors.white),
            icon: Badge(label: Text('2'), child: Icon(Icons.document_scanner)),
            label: 'Leave',
          ),
        ],
      ),
      body: [
        const DashboardPage(),
        const DTRPage(),
        const LeaveApplication()
      ][currentPageIndex],
    );
  }
}