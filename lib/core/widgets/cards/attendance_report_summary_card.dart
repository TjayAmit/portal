import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_report_controller.dart';

class AttendanceSummaryWidget extends ConsumerWidget {
  const AttendanceSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceReportControllerProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Text(
          state.error!,
          style: TextStyle(color: theme.colorScheme.error, fontSize: 13),
        ),
      );
    }

    if (state.report == null) {
      return const Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
    }

    final report = state.report!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Row(
            children: [
              Icon(Icons.assessment_rounded,
                  size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                "Attendance Summary",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 🔹 Cards Row
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  context: context,
                  icon: Icons.remove_circle_outline,
                  label: "Absences",
                  value: "${report.absences}",
                  color: Colors.redAccent,
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF8B0000), Colors.black26]
                        : [const Color(0xFFFFEBEE), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  context: context,
                  icon: Icons.access_time_outlined,
                  label: "Tardiness",
                  value: "${report.tardinessCount}",
                  color: Colors.orangeAccent,
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF8B5E00), Colors.black26]
                        : [const Color(0xFFFFF3E0), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Gradient gradient,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Icon bubble
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),

          // 🔹 Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
