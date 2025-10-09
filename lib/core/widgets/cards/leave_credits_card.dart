import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/leave_applications/provider/leave_provider.dart';

class LeaveCreditsCard extends ConsumerWidget {
  const LeaveCreditsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveState = ref.watch(leaveControllerProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (leaveState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (leaveState.error != null) {
      return Center(
        child: Text(
          'Error loading leave balances: ${leaveState.error}',
          style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
        ),
      );
    }

    final leaveBalances = leaveState.leaveBalances;

    if (leaveBalances.isEmpty) {
      return const Center(child: Text('No leave balances available'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.calendar_month_outlined, color: theme.primaryColor, size: 18),
              const SizedBox(width: 8),
              Text(
                'My Leave Credits',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 18),
                onPressed: () =>
                    ref.read(leaveControllerProvider.notifier).fetchLeaveBalances(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: 'Refresh',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Horizontal Scrollable Row
          SizedBox(
            height: 85,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: leaveBalances.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildLeaveCard(
                      context: context,
                      type: entry.key,
                      days: entry.value,
                      color: _getLeaveTypeColor(entry.key),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // View all
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(
          //     onPressed: () {
          //       // TODO: Navigate to leave application page
          //     },
          //     style: TextButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //       minimumSize: Size.zero,
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     ),
          //     child: Text(
          //       'View All →',
          //       style: textTheme.labelSmall?.copyWith(
          //         color: theme.primaryColor,
          //         fontWeight: FontWeight.w500,
          //         fontSize: 11,
          //         height: 1.1,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Leave card
  Widget _buildLeaveCard({
    required BuildContext context,
    required String type,
    required double days,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.12 : 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getLeaveIcon(type),
                  color: color,
                  size: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${days.toStringAsFixed(1)}d',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _formatLeaveType(type),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Available',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontSize: 10,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // Helpers
  IconData _getLeaveIcon(String type) {
    switch (type.toLowerCase()) {
      case 'sick_leave':
        return Icons.medical_services_outlined;
      case 'vacation_leave':
        return Icons.beach_access_outlined;
      case 'maternity_leave':
        return Icons.family_restroom_outlined;
      case 'paternity_leave':
        return Icons.male_outlined;
      case 'special_leave':
        return Icons.star_outline_rounded;
      default:
        return Icons.calendar_today_outlined;
    }
  }

  String _formatLeaveType(String type) {
    return type
        .split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  Color _getLeaveTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'sick_leave':
        return const Color(0xFF4A6BFF);
      case 'vacation_leave':
        return const Color(0xFF4CAF50);
      case 'maternity_leave':
        return const Color(0xFF9C27B0);
      case 'paternity_leave':
        return const Color(0xFF2196F3);
      case 'special_leave':
        return const Color(0xFFFF9800);
      default:
        return Colors.grey;
    }
  }
}
