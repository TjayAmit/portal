import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_report_controller.dart';

class AttendanceReportPage extends ConsumerWidget {
  const AttendanceReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(attendanceReportControllerProvider);
    final controller = ref.read(attendanceReportControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Report'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadReport(),
          ),
        ],
      ),
      body: reportState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : reportState.error != null
              ? Center(child: Text(reportState.error!))
              : reportState.report == null
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () => controller.loadReport(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Load Report'),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Summary (October 2025)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          AttendanceReportCard(
                            icon: Icons.event_available,
                            label: 'Total Working Days',
                            value: '${reportState.report!.totalDays}',
                            color: Colors.blueAccent,
                          ),
                          AttendanceReportCard(
                            icon: Icons.remove_circle_outline,
                            label: 'Absences',
                            value: '${reportState.report!.absences}',
                            color: Colors.redAccent,
                          ),
                          AttendanceReportCard(
                            icon: Icons.access_time,
                            label: 'Tardiness Count',
                            value: '${reportState.report!.tardinessCount}',
                            color: Colors.orangeAccent,
                          ),
                          AttendanceReportCard(
                            icon: Icons.timer,
                            label: 'Total Late Minutes',
                            value: '${reportState.report!.totalLateMinutes} mins',
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    ),
    );
  }
}

class AttendanceReportCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const AttendanceReportCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(label),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}