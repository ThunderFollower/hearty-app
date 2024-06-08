import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../examination.dart';
import 'body/examination_body.dart';
import 'providers.dart';

@RoutePage()
class ExaminationPage extends ConsumerStatefulWidget {
  const ExaminationPage({
    super.key,
    @PathParam(examinationIdParam) this.examinationId = '',
  });

  final String examinationId;

  @override
  ConsumerState<ExaminationPage> createState() => _ExaminationPageState();
}

class _ExaminationPageState extends ConsumerState<ExaminationPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(examinationStateProvider.notifier)
          .init(id: widget.examinationId);
      ref.watch(permissionService(Permission.locationWhenInUse)).grant();
    });
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const _BodyView(),
      );
}

/// The [examination] is mutable if it's mine.
bool _isMutable(Examination examination) => examination.from == null;

const _boxSize = 60.0;

class _BodyView extends ConsumerWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationStateProvider.select(
      (state) => state.examination,
    );
    final asyncValue = ref.watch(provider);

    return asyncValue.when(
      data: (examination) => _DataView(examination),
      loading: () => const _Skeleton(),
      error: (_, __) => const _ErrorView(),
    );
  }
}

class _DataView extends StatelessWidget {
  const _DataView(this.data);

  final Examination data;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mutable = _isMutable(data);

    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.padding.top),
      child: ExaminationBody(examination: data, mutable: mutable),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final indicator = CircularProgressIndicator(color: color);
    final container = SizedBox(
      width: _boxSize,
      height: _boxSize,
      child: indicator,
    );

    return Center(child: container);
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const SkeletonLine()),
      body: const _Skeleton(),
    );
  }
}
