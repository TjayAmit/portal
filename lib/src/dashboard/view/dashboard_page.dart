import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/cards/leave_credits_card.dart';
import 'package:zcmc_portal/core/widgets/cards/today_dtr_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const TodayDTRWidget(),
        const SizedBox(height: 20),
        const LeaveCreditsCard(),
      ],
    );
  }
}