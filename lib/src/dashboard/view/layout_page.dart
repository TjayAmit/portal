
import 'package:flutter/material.dart';
import 'package:zcmc_portal/src/dashboard/view/dashboard_page.dart';

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
      appBar: AppBar(
        title: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Zamboanga City Medical Center", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              Text("Dr. Evangelista St., Sta Catalina, Zamboanga City, 7000", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/personal-information'), 
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Text(
                  'G',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
      body: [
        const DashboardPage(),

        /// Notifications page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(child: Text('Notification page', style: theme.textTheme.titleLarge)),
          ),
        ),

        /// Messages page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(child: Text('Messages page', style: theme.textTheme.titleLarge)),
          ),
        ),
      ][currentPageIndex],
    );
  }
}