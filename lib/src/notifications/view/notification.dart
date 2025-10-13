import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/notifications/controller/notification_state.dart';
import 'package:zcmc_portal/src/notifications/provider/notification.dart';
import 'package:zcmc_portal/src/notifications/model/notification.dart' as notification;

class NotificationPage extends ConsumerStatefulWidget {
    const NotificationPage({super.key});

    @override
    ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
    @override
    void initState() {
        super.initState();
        // Load DTR data when the page initializes
        WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(notificationControllerProvider).getNotification();
        });
    }

    @override
    Widget build(BuildContext context) {
        final notificationState = ref.watch(notificationStateProvider);
        final notificationList = ref.watch(notificationListProvider);

        return Scaffold(
            appBar: AppBar(
                title: const Text('Notification'),
            ),
            body: _buildBody(notificationState, notificationList),
        );
    }

    Widget _buildBody(NotificationState state, List<notification.Notification> notificationList){
        if (state is NotificationStateLoading){
            return const Center(child: CircularProgressIndicator());
        }

        if (state is NotificationStateError){
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                            state.message,
                            style: const TextStyle(fontSize: 16, color: Colors.red),
                            textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () => ref.read(notificationControllerProvider).getNotification(),
                            child: const Text('Retry'),
                        ),
                    ],
                ),
            );
        }

        if (state is NotificationStateSuccess && notificationList.isEmpty){
            return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(Icons.access_time, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                            'No DTR records found',
                            style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                    ],
                ),
            );
        }
        
        return ListView.builder(
            itemCount: notificationList.length,
            itemBuilder: (context, index) {
                final notification = notificationList[index];
                return _buildNotificationCard(notification);
            },
        );
    }

    Widget _buildNotificationCard(notification.Notification notification){
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                    ),
                ),
            ),
            child: ListTile(
                title: Text(
                    notification.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notification.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                    // Navigate to notification details if needed
                },
            ),
        );
    }
}