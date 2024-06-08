import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../use_cases/use_cases.dart';
import '../link_handler.dart';
import '../link_handler_adapter.dart';

final linkHandlerProvider = Provider.autoDispose<LinkHandler>(
  (ref) => LinkHandlerAdapter(
    openEmailAppUseCase: ref.watch(openEmailAppProvider),
  ),
);
