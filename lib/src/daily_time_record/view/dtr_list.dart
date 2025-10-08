import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/utils/date_time.dart';
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

    return  Stack(
      alignment: Alignment.topRight,
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: SizedBox(
            child: _buildBody(dtrState, dtrList),
          ),
        ),
        Positioned(
          top: 0,
          child: SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily Time Record'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(
                  child: Row(
                    children: [
                      Text('Month', style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: 'October',
                        onChanged: (String? value) {},
                        items: const <DropdownMenuItem<String>>[
                          DropdownMenuItem<String>(value: 'January', child: Text('January')),
                          DropdownMenuItem<String>(value: 'February', child: Text('February')),
                          DropdownMenuItem<String>(value: 'March', child: Text('March')),
                          DropdownMenuItem<String>(value: 'April', child: Text('April')),
                          DropdownMenuItem<String>(value: 'May', child: Text('May')),
                          DropdownMenuItem<String>(value: 'June', child: Text('June')),
                          DropdownMenuItem<String>(value: 'July', child: Text('July')),
                          DropdownMenuItem<String>(value: 'August', child: Text('August')),
                          DropdownMenuItem<String>(value: 'September', child: Text('September')),
                          DropdownMenuItem<String>(value: 'October', child: Text('October')),
                          DropdownMenuItem<String>(value: 'November', child: Text('November')),
                          DropdownMenuItem<String>(value: 'December', child: Text('December')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
          convertDateToName(dtr.date!),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Time In: ${dtr.timeIn ?? 'N/A'}'),
              Text('Break Out: ${dtr.breakOut ?? 'N/A'}'),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Break In: ${dtr.breakIn ?? 'N/A'}'),
              Text('Time Out: ${dtr.timeOut ?? 'N/A'}'),
            ]),
            Text('Over Time: ${dtr.overTime ?? 'N/A'}'),
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