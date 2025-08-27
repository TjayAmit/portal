import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/app_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portal"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Text("Dashboard"),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/daily-time-record'),
            child: Text("Daily Time Record"),
          ),
        ],
      ),
    );
  }
}