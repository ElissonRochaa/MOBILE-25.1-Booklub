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

  Widget _buidAppBar(BuildContext context) => PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      title: Text('Booklub'),
      actions: _getActions(),
    ),
  );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
    floating: true,
    title: Text('Booklub'),
    actions: _getActions(),
  );

  List<Widget> _getActions() => [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.add_alert),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ];

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
