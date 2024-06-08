import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

/// Defines a state of an account list.
typedef AccountListState = AsyncValue<List<Credentials>>;
