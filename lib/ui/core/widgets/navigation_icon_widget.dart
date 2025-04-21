import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationIconWidget extends StatelessWidget {

  final IconData icon;

  final bool selected;

  final String destination;

  const NavigationIconWidget({
    super.key,
    required this.icon,
    required this.selected,
    required this.destination
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
        onPressed: () {
          context.go(destination);
        },
        icon: Icon(
          icon,
          size: 36,
          color: selected ? colorScheme.primary : colorScheme.secondary,
        )
    );
  }

}
