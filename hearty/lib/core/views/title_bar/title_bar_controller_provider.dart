import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router_provider.dart';
import 'title_bar_controller.dart';

/// Provides the [TitleBarController] to the Title Bar.
final titleBarControllerProvider = Provider.autoDispose<TitleBarController>(
  (ref) => TitleBarController(ref.watch(routerProvider)),
);
