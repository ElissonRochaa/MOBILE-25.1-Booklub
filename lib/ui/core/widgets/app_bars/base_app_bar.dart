import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  final bool sliver;

  const BaseAppBar({
    super.key,
    this.height=kToolbarHeight
  }): sliver=false;

  const BaseAppBar.sliver({
    super.key,
    this.height=kToolbarHeight
  }): sliver=true;

  @override
  Widget build(BuildContext context) => sliver
      ? Builder(builder: _buildSliverAppBar)
      : Builder(builder: _buidAppBar);

  Widget _buidAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Booklub',
          style: _getTextStyle(colorScheme),
        ),
        actions: _getActions(colorScheme),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Booklub',
        style: _getTextStyle(colorScheme),
      ),
      actions: _getActions(colorScheme),
    );
  }

  TextStyle _getTextStyle(ColorScheme colorScheme) {
    final shadows = <Shadow>[
      Shadow(
          color: colorScheme.black,
          blurRadius: 4,
          offset: Offset(-1, 1)
      )
    ];

    return TextStyle(
      fontFamily: 'Navicula',
      color: colorScheme.primary,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      shadows: shadows,
    );
  }

  List<Widget> _getActions(ColorScheme colorScheme) => [
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
  ];

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
