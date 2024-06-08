import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';

final envUrlProvider = StateProvider<String>((_) => Config.baseUrl);
