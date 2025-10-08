import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/provider/attendance_provider.dart';

class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendance = ref.watch(attendanceControllerProvider);
    final controller = ref.read(attendanceControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              attendance.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            if (attendance.canAuthWithBio)
              ElevatedButton.icon(
                onPressed: () async {
                  await controller.authenticateAndRegisterAttendance();
                },
                icon: const Icon(Icons.fingerprint),
                label: const Text("Tap to Register Attendance"),
              ),
          ],
        ),
      ),
    );
  }
}
