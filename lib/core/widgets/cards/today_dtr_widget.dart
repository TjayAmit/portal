import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/button/biometric.dart';

class TodayDTRWidget extends StatelessWidget {
  const TodayDTRWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

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
            // Header row
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

            // Time logs
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLog(context, 'Time-in', '08:00 AM'),
                  _divider(context),
                  _buildLog(context, 'Break-out', '12:00 PM'),
                  _divider(context),
                  _buildLog(context, 'Break-in', '12:05 PM'),
                  _divider(context),
                  _buildLog(context, 'Time-out', '--:-- PM'),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
