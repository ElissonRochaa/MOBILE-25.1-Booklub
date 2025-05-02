import 'package:flutter/material.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  final bool sliver;

  const BaseAppBarWidget({
    super.key,
    this.height=kToolbarHeight
  }): sliver=false;

  const BaseAppBarWidget.sliver({
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
