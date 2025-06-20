import 'package:booklub/config/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseFloatingActionButtonWidget extends StatelessWidget {

  final VoidCallback? onPressed;

  const BaseFloatingActionButtonWidget({
    super.key,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed ?? () => context.push(Routes.createClub),
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

}
