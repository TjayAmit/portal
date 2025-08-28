import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/cards/personal_information_card.dart';
import 'package:zcmc_portal/core/widgets/cards/today_dtr_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const PersonalInformationCard(),
            const SizedBox(height: 20),
            const TodayDTRWidget(),
          ],
        ),
      );
  }
}