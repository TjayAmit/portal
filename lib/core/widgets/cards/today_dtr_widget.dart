import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/widgets/button/biometric.dart';
import 'package:zcmc_portal/src/today_log/provider/today_log_provider.dart';
import 'package:zcmc_portal/src/today_log/controller/today_log_state.dart';
import 'package:zcmc_portal/src/today_log/model/today_log_model.dart';

class TodayDTRWidget extends ConsumerWidget {
  const TodayDTRWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    final todayLogState = ref.watch(todayLogStateProvider);

    TodayLogModel dtr = TodayLogModel(); // fallback initial value

    if (todayLogState is TodayLogStateSuccess) {
      dtr = todayLogState.dtr;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.15 : 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ROW ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: theme.primaryColor, size: 18),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Logs",
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "Check your daily time record",
                      style: textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Biometric(),
              ],
            ),

            const SizedBox(height: 12),

            // --- DTR LOG ROW ---
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: _buildLogsRow(context, dtr),
            ),

            // Optional loading or error messages
            if (todayLogState is TodayLogStateLoading)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            if (todayLogState is TodayLogStateError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Text(
                    "⚠️ Failed to load DTR: ${todayLogState.message}",
                    style: textTheme.labelSmall?.copyWith(color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsRow(BuildContext context, TodayLogModel dtr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLog(context, 'Time-in', _formatTime(dtr.timeIn)),
        _divider(context),
        _buildLog(context, 'Break-out', _formatTime(dtr.breakOut)),
        _divider(context),
        _buildLog(context, 'Break-in', _formatTime(dtr.breakIn)),
        _divider(context),
        _buildLog(context, 'Time-out', _formatTime(dtr.timeOut)),
      ],
    );
  }

  Widget _buildLog(BuildContext context, String title, String time) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 22,
      width: 1,
      color: theme.colorScheme.onSurface.withOpacity(0.15),
    );
  }

  String _formatTime(String? isoTime) {
    if (isoTime == null || isoTime.isEmpty) return '--:--';
    try {
      final time = DateTime.parse(isoTime);
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final minute = time.minute.toString().padLeft(2, '0');
      final ampm = time.hour >= 12 ? 'PM' : 'AM';
      return "$hour:$minute $ampm";
    } catch (_) {
      return isoTime;
    }
  }
}
