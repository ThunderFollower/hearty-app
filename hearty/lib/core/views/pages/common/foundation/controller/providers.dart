import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../index.dart';
import 'foundation_page_controller.dart';
import 'foundation_page_controller_adapter.dart';

/// Provides a disposable instance of [FoundationPageController].
///
/// Utilizes [FoundationPageControllerAdapter].
final foundationPageControllerProvider =
    Provider.autoDispose<FoundationPageController>(
  (ref) => FoundationPageControllerAdapter(
    router: ref.watch(routerProvider),
  ),
);
