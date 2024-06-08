import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'empty/empty_received_list.dart';
import 'list/received_list.dart';
import 'list/received_list_controller.dart';

class ReceivedView extends ConsumerStatefulWidget {
  const ReceivedView({super.key});

  @override
  ConsumerState<ReceivedView> createState() => _ReceivedViewState();
}

class _ReceivedViewState extends ConsumerState<ReceivedView>
    with AutomaticKeepAliveClientMixin<ReceivedView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final examinations = ref.watch(
      receivedListStateProvider.select((state) => state.examinations),
    );

    if (examinations == null) {
      return const CircularProgressIndicator(color: Colors.pink);
    }

    final child = (examinations.isNotEmpty)
        ? const ReceivedList()
        : const EmptyReceivedList();

    return Expanded(child: child);
  }

  @override
  bool get wantKeepAlive => true;
}
