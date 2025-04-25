import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BaseSliverAppBar extends StatelessWidget {
  const BaseSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

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

    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Booklub', style: textStyle,),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          color: colorScheme.primary,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.add_alert),
          color: colorScheme.primary,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          color: colorScheme.primary,
          onPressed: () {},
        ),
      ],
    );
  }

}
