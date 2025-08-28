
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/utils/date_time.dart';
import 'package:zcmc_portal/src/schedule/providers/schedule_provider.dart';
import 'package:zcmc_portal/src/schedule/controller/schedule_state.dart';
import 'package:zcmc_portal/src/schedule/model/schedule_model.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage>{
  @override
  void initState() {
    super.initState();
    // Load DTR data when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scheduleControllerProvider).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleStateProvider);
    final scheduleList = ref.watch(scheduleListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(scheduleControllerProvider).get(),
          ),
        ],
      ),
      body: _buildBody(scheduleState, scheduleList),
    );
  }

  Widget _buildBody(ScheduleState state, List<ScheduleModel> scheduleList){
    if(state is ScheduleLoading){
      return const Center(child: CircularProgressIndicator());
    }

    if(state is ScheduleError){
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
              onPressed: () => ref.read(scheduleControllerProvider).get(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if(state is ScheduleSuccess){
      return ListView.builder(
        itemCount: scheduleList.length,
        itemBuilder: (context, index) {
          final schedule = scheduleList[index];
          return _buildScheduleCard(schedule);
        },
      );
    }

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No DTR records found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(ScheduleModel schedule){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.access_time, color: Colors.blue),
        title: Text(
          convertDateToDay(schedule.date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schedule.time),
            Text(schedule.date)
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to DTR details if needed
        },
      ),
    );
  }
}