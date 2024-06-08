import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_router.gr.dart';
import '../../../examination/views/connection/config/connection_controller_provider.dart';
import '../../../generated/locale_keys.g.dart';
import '../../views.dart';

class ConnectionServerErrorInterceptor extends Interceptor {
  final Ref _ref;
  late final Dio _api;

  ConnectionServerErrorInterceptor(this._ref, this._api);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!isServerIssue(err)) return handler.next(err);

    final connectionErrorRoute = _getServerIssueRoute(err, handler);
    _ref
        .read(connectionControllerProvider.notifier)
        .checkIfUserIsAuthenticated();

    final router = _ref.read(routerProvider);

    // Do not show `Something_went_wrong` error if the internet
    // connection is lost.
    // It prevents overlapping of the error pages.
    if (!_containsConnectionLostError(router.stack)) {
      router.push(connectionErrorRoute);
    }
  }

  bool _containsConnectionLostError(List<AutoRoutePage> routes) =>
      routes.any((e) => e.name == ConnectionErrorRoute.name);

  ConnectionErrorRoute _getServerIssueRoute(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    return ConnectionErrorRoute(
      title: LocaleKeys.Something_went_wrong.tr(),
      description: LocaleKeys.Service_will_be_restored_soon.tr(),
      imagePath: 'assets/images/error.svg',
      tryAgainTap: () => _retryRequest(error, handler),
    );
  }

  Future<void> _retryRequest(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    _ref.read(routerProvider).pop();
    try {
      final response = await _api.request(
        error.requestOptions.path,
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
        options: Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        ),
      );
      return handler.resolve(response);
    } on DioException catch (err) {
      if (isServerIssue(err)) {
        onError(err, handler);
      } else {
        handler.reject(err);
      }
    }
  }

  bool isServerIssue(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.unknown;
  }
}
