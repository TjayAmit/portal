import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/widgets/app_drawer.dart';
import 'package:zcmc_portal/src/daily_time_record/controller/dtr_state.dart';
import 'package:zcmc_portal/src/daily_time_record/model/dtr_model.dart';
import 'package:zcmc_portal/src/daily_time_record/providers/dtr_provider.dart';

class DTRPage extends ConsumerStatefulWidget {
  const DTRPage({super.key});

  @override
  ConsumerState<DTRPage> createState() => _DTRPageState();
}

class _DTRPageState extends ConsumerState<DTRPage> {
  @override
  void initState() {
    super.initState();
    // Load DTR data when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dtrControllerProvider).getDTR();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dtrState = ref.watch(dtrStateProvider);
    final dtrList = ref.watch(dtrListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Time Record'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(dtrControllerProvider).getDTR(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _buildBody(dtrState, dtrList),
    );
  }

  Widget _buildBody(DTRState state, List<DTRModel> dtrList) {
    if (state is DTRStateLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is DTRStateError) {
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
              onPressed: () => ref.read(dtrControllerProvider).getDTR(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is DTRStateSuccess && dtrList.isEmpty) {
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

    return ListView.builder(
      itemCount: dtrList.length,
      itemBuilder: (context, index) {
        final dtr = dtrList[index];
        return _buildDTRCard(dtr);
      },
    );
  }

  Widget _buildDTRCard(DTRModel dtr) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.access_time, color: Colors.blue),
        title: Text(
          'Biometric ID: ${dtr.biometricId}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time In: ${dtr.timeIn}'),
            Text('Time Out: ${dtr.timeOut}'),
            Text('Break Out: ${dtr.breakOut}'),
            Text('Break In: ${dtr.breakIn}'),
            Text('Over Time: ${dtr.overTime}'),
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