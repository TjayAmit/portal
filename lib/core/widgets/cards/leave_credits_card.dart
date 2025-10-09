
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
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Leave Credits',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref.read(leaveControllerProvider.notifier).fetchLeaveBalances(),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...leaveBalances.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatLeaveType(entry.key),
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getLeaveTypeColor(entry.key).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${entry.value.toStringAsFixed(1)} days',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getLeaveTypeColor(entry.key),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _formatLeaveType(String type) {
    return type.split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  Color _getLeaveTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'sick_leave':
        return Colors.blue;
      case 'vacation_leave':
        return Colors.green;
      case 'maternity_leave':
        return Colors.purple;
      case 'paternity_leave':
        return Colors.blue[800]!;
      case 'special_leave':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}      