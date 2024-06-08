import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

/// Adds the 'Accept-Language' header to the HTTP request to specify the user's
/// language preferences.
class LocalizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_acceptLanguage] = Intl.getCurrentLocale();
    super.onRequest(options, handler);
  }
}

const _acceptLanguage = 'Accept-Language';
