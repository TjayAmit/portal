import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/utils/date_time.dart';

class TodayDTRWidget extends StatelessWidget {
  const TodayDTRWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [ 
              Text("Today's Logs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),  
              const Spacer(),
              Column(
                children: [
                  Text(convertDateToDay(DateTime.now().toString()), style: TextStyle(decoration: TextDecoration.underline)),
                  Text(convertDateToName(DateTime.now().toString())),
                ],
              )
            ]),
            const Divider(thickness: 1),
            Row(
              children: [
                _buildLog('Time-in', '08:00 AM'),
                const Spacer(),
                _buildLog('Break-out', '12:00 PM'),
                const Spacer(),
                _buildLog('Break-in', '12:05 PM'),
                const Spacer(),
                _buildLog('Time-out', '--:-- PM'),
              ],
            )
          ],
        ),
      ), 
    );
  }

  Widget _buildLog(String title, String time) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
        Text(time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
      ],
    );
  }
}