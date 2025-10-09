import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/button/biometric.dart';

class TodayDTRWidget extends StatelessWidget {
  const TodayDTRWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 5),
            child: Row(
              children: [ 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("TODAY LOGS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),  
                    Text("Check your daily time record.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),  
                  ],
                ),
              const Spacer(),
              const Biometric()
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildLog('Time-in', '08:00 AM'),
                  const Spacer(),
                  _buildLog('Break-out', '12:00 PM'),
                  const Spacer(),
                  _buildLog('Break-in', '12:05 PM'),
                  const Spacer(),
                  _buildLog('Time-out', '--:-- PM'),
                ],
              ),
            ),
          )
        ],
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