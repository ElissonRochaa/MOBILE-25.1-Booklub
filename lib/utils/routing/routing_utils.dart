import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract final class RoutingUtils {

  static String getRoute(BuildContext context) {
    final router = GoRouter.of(context);
    return router.routeInformationProvider.value.uri.toString();
  }

}