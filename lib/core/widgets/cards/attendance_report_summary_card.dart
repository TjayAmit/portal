import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_report_controller.dart';

class AttendanceSummaryWidget extends ConsumerWidget {
  const AttendanceSummaryWidget({super.key});

  static const int maxAbsences = 3;
  static const int maxTardiness = 10;

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
          'No attendance summary available',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      );
    }

    final report = state.report!;
    final absenceRatio = (report.absences / maxAbsences).clamp(0.0, 1.0);
    final tardyRatio = (report.tardinessCount / maxTardiness).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Row(
            children: [
              Icon(Icons.assessment_outlined,
                  size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                "Attendance Summary",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 🔹 Cards Row
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  context: context,
                  label: "Absences",
                  value: report.absences,
                  max: maxAbsences,
                  color: Colors.redAccent,
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF5A0A0A), Colors.black26]
                        : [const Color(0xFFFFEBEE), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.remove_circle_outline,
                  progress: absenceRatio,
                  exceeded: report.absences > maxAbsences,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryCard(
                  context: context,
                  label: "Tardiness",
                  value: report.tardinessCount,
                  max: maxTardiness,
                  color: Colors.orangeAccent,
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF6B4800), Colors.black26]
                        : [const Color(0xFFFFF3E0), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.access_time_outlined,
                  progress: tardyRatio,
                  exceeded: report.tardinessCount > maxTardiness,
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
    required String label,
    required int value,
    required int max,
    required double progress,
    required Color color,
    required Gradient gradient,
    required IconData icon,
    required bool exceeded,
  }) {
    final theme = Theme.of(context);
    final adjustedColor =
        exceeded ? color.withRed((color.red + 60).clamp(0, 255)) : color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: adjustedColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: adjustedColor, size: 15),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                    color: theme.colorScheme.onSurface.withOpacity(0.85),
                  ),
                ),
              ),
              Text(
                exceeded ? "Over limit" : "$value / $max",
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  color: exceeded
                      ? Colors.redAccent
                      : theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // 🔹 Value + Progress Bar
          Row(
            children: [
              Text(
                "$value",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: adjustedColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                value == 1 ? "record" : "records",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: adjustedColor.withOpacity(0.08),
              color: adjustedColor,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}
