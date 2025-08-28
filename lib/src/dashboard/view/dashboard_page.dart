import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/app_drawer.dart';
import 'package:zcmc_portal/core/widgets/cards/personal_information_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const PersonalInformationCard(),
          ],
        ),
      ),
    );
  }
}