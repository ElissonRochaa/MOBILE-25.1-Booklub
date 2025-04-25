import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const BaseAppBar({super.key, this.height=kToolbarHeight});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final shadows = <Shadow>[
      Shadow(
        color: colorScheme.black,
        blurRadius: 4,
        offset: Offset(-1, 1)
      )
    ];

    final textStyle = TextStyle(
      fontFamily: 'Navicula',
      color: colorScheme.primary,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      shadows: shadows,
    );

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Booklub', style: textStyle,)
      ),
    );

  }

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
